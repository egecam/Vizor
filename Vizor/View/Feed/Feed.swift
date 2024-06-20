//
//  Feed.swift
//  Vizor
//
//  Created by Ege Çam on 11.06.2024.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

@MainActor
final class FeedViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var selectedImage: UIImage? = nil
    
    private var db = Firestore.firestore()
    private var user: User? {
        return Auth.auth().currentUser
    }
    
    func fetchPosts() {
        db.collection("posts").order(by: "timestamp", descending: true).addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.posts = documents.compactMap { queryDocumentSnapshot -> Post? in
                return try? queryDocumentSnapshot.data(as: Post.self)
            }
        }
    }
    
    func addPost(image: UIImage, title: String) async {
        do {
            guard let user = user else { return }
            let imageURL = try await uploadImage(image: image)
            let newPost = Post(imageURL: imageURL, title: title, timestamp: Date(), userID: user.uid)
            let _ = try db.collection("posts").addDocument(from: newPost)
        } catch {
            print(error)
        }
    }
    
    func uploadImage(image: UIImage) async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            FirebaseStorageManager.shared.uploadImage(image) { result in
                switch result {
                case .success(let url):
                    continuation.resume(returning: url)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}

struct Feed: View {
    @StateObject private var viewModel = FeedViewModel()
    @Binding var showSignInView: Bool
    @State private var showImagePicker: Bool = false
    @State private var newPostTitle: String = ""
    @State private var showNewPostView = false
    
    @State private var showingHeader = true
    @State private var turningPoint = CGFloat.zero
    let thresholdScrollDistance: CGFloat = 50
    
    var body: some View {
        VStack {
            
            // MARK: HEADER
            if showingHeader {
                HStack {
                    HStack(alignment: .center) {
                        Text("Vizor")
                            .font(.custom("AntiqueSerie-Regular", size: 38))
                        Text("Feed")
                            .font(.system(size: 36))
                            .fontWeight(.light)
                    }
                    .foregroundStyle(.white)
                    .safeAreaPadding()
                    
                    Spacer()
                    
                    Button(action: {
                        Task {
                            do {
                                try viewModel.signOut()
                                showSignInView = true
                            } catch {
                                print(error)
                            }
                        }
                    }, label: {
                        Text("Log Out")
                            .font(.overused(size: 20, width: 100, weight: 400))
                            .foregroundStyle(.white)
                            .bold()
                            .padding()
                    })
                    .buttonStyle(BorderlessButtonStyle())
                }
                .transition(
                    .asymmetric(
                        insertion: .push(from: .top),
                        removal: .push(from: .bottom)
                    )
                )
            }
            
            GeometryReader { outer in
                let outerHeight = outer.size.height
                
                // MARK: SCROLLVIEW FOR ALL POSTS
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.posts) { post in
                            VStack(alignment: .leading) {
                                // Post Image
                                AsyncImage(url: URL(string: post.imageURL)) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(maxHeight: 300)
                                            .clipped()
                                    } else if phase.error != nil {
                                        Color.red
                                            .frame(maxHeight: 300)
                                    } else {
                                        Color.gray
                                            .frame(maxHeight: 300)
                                    }
                                }
                                .cornerRadius(10)
                                
                                // Post Title
                                Text(post.title)
                                    .font(.vollkorn(size: 20, width: 100, weight: 700))
                                    .padding(.top, 8)
                                
                                // Post Timestamp
                                Text("\(post.timestamp, formatter: postDateFormatter)")
                                    .font(.overused(size: 16, width: 100, weight: 400))
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding(.horizontal)
                        }
                        
                        VStack {
                            Text("That's all for now.")
                                .font(.vollkorn(size: 24, width: 100, weight: 500))
                            
                            Text("Comeback later! 👋")
                                .font(.overused(size: 18, width: 100, weight: 400))
                        }
                        .frame(height: 225)
                        .padding()
                        .foregroundStyle(.white)
                        
                    }
                    
                    .background {
                        GeometryReader { proxy in
                            let contentHeight = proxy.size.height
                            let minY = max(
                                min(0, proxy.frame(in: .named("ScrollView")).minY),
                                outerHeight - contentHeight
                            )
                            Color.clear
                                .onChange(of: minY) { oldValue, newValue in
                                    if (showingHeader && newValue > oldValue) || (!showingHeader && newValue < oldValue) {
                                        turningPoint = newValue
                                    }
                                    if (showingHeader && 
                                        (turningPoint - newValue) >
                                        thresholdScrollDistance) ||
                                        (!showingHeader && 
                                         (newValue - turningPoint) >
                                         thresholdScrollDistance) {
                                        showingHeader = newValue > turningPoint
                                    }
                                }
                        }
                    }
                }
                
                .coordinateSpace(name: "ScrollView")
                .refreshable {
                    viewModel.fetchPosts()
                }
            }
            .padding(.top, 1)
        }
        .background(.black)
        .animation(.easeInOut, value: showingHeader)
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.fetchPosts()
        }
        
        .overlay(
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showNewPostView = true
                    }) {
                        Image(systemName: "plus")
                            .foregroundStyle(.white)
                            .padding()
                            .background(Color.sunrise)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
        )
        .sheet(isPresented: $showNewPostView) {
            NewPostView()
        }
    }
}

// Helper date formatter
private let postDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
}()

#Preview {
    Feed(showSignInView: .constant(false))
}


