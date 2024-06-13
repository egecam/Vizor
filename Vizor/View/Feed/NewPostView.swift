//
//  NewPostView.swift
//  Vizor
//
//  Created by Ege Çam on 11.06.2024.
//

import SwiftUI

struct NewPostView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = FeedViewModel()
    @State private var title = ""
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var isUploading = false
    @State private var showDeleteButton = false
    @State private var dragOffset = CGSize.zero
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack {
                    TextField("", text: $title, prompt: Text("Title").foregroundStyle(.white.opacity(0.25)))
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.bottom, 20)
                        .foregroundStyle(.white)
                    
                    if selectedImage != nil {
                        ZStack {
                            Image(uiImage: selectedImage!)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .cornerRadius(10)
                                .padding(.bottom, 20)
                                .onLongPressGesture(minimumDuration: 1) {
                                    withAnimation {
                                        showDeleteButton = true
                                    }
                                }
                                .offset(dragOffset)
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            dragOffset = value.translation
                                        }
                                        .onEnded { value in
                                            if abs(value.translation.width) < 50 && value.translation.height > 200 {
                                                withAnimation {
                                                    selectedImage = nil
                                                    showDeleteButton = false
                                                }
                                            }
                                            dragOffset = .zero
                                        }
                                )
                            
                            if showDeleteButton {
                                HStack {
                                    Image(systemName: "xmark.circle")
                                        .foregroundColor(.gray)
                                        .frame(maxWidth: .infinity)
                                        .font(.largeTitle)
                                        .padding()
                                        .offset(y: 200)
                                }
                            }
                        }
                    } else {
                        Button("Select Image") {
                            isImagePickerPresented = true
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.bottom, 20)
                        .foregroundStyle(.white)
                    }
                    
                    if isUploading {
                        ProgressView("Uploading...")
                            .padding()
                    } else {
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                guard !title.isEmpty, let selectedImage = selectedImage else { return }
                                Task {
                                    isUploading = true
                                    await viewModel.addPost(image: selectedImage, title: title)
                                    isUploading = false
                                    dismiss()
                                }
                            }) {
                                Text("Share")
                                    .bold()
                                    .padding()
                                    .background(.sunrise)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .padding(.top, 20)
                        }
                    }
                    
                    Spacer()
                }
                .background(.black)
                .navigationTitle("New Post")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(image: $selectedImage)
                }
            }
        }
    }
}

#Preview {
    NewPostView()
}

