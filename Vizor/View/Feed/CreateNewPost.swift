//
//  CreateNewPost.swift
//  Vizor
//
//  Created by Ege Çam on 3.06.2024.
//

import SwiftUI

struct CreateNewPost: View {
    @State private var title: String = ""
    @State private var image: String = ""
    
    @Binding var isUserLoggedIn: Bool
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(alignment: .center) {
                // Image
                
                ZStack {
                    Color.gray.opacity(0.2)
                    
                    TextField("", text: $title, prompt: Text("Select Image").foregroundStyle(.white.opacity(0.25)))
                }
                .frame(width: 200, height: 200)
                .clipShape(.rect(cornerRadius: 10.0))
                
                ZStack {
                    Color.gray.opacity(0.2)
                    
                    TextField("", text: $title, prompt: Text("Title").foregroundStyle(.white.opacity(0.25)))
                }
                .frame(width: 200, height: 35)
                .clipShape(.rect(cornerRadius: 10.0))
                
                HStack {
                    NavigationLink(destination: Feed(isUserLoggedIn: $isUserLoggedIn).onAppear {
                        
                    }) {
                        Text("Cancel")
                            .foregroundStyle(.tangerine)
                    }
                    .padding()
                    
                    NavigationLink(destination: Feed(isUserLoggedIn: $isUserLoggedIn).onAppear {
                        
                    }) {
                        Text("Publish")
                            .foregroundStyle(.sunrise)
                    }
                    .buttonStyle(BorderedButtonStyle())
                .padding()
                    
                    
                }
            }
            .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    CreateNewPost(isUserLoggedIn: .constant(false))
}
