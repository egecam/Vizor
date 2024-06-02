//
//  SignUpView.swift
//  Vizor
//
//  Created by Ege Çam on 3.06.2024.
//

import SwiftUI
import SwiftData

struct SignInView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var users: [User]
    @Binding var isUserLoggedIn: Bool
    @State var isSignUpViewCalled: Bool = true
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack {
                    VStack {
                        Text("Your Pocket Viewfinder")
                            .textCase(.uppercase)
                            .foregroundStyle(.sunrise.opacity(0.7))
                            .font(.system(size: 17))
                            .fontWeight(.medium)
                        
                        HStack(alignment: .center) {
                            Text("Vizor")
                                .font(.custom("AntiqueSerie-Regular", size: 50))
                            Text("Feed")
                                .font(.system(size: 48))
                                .fontWeight(.light)
                        }
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 18.0))
                    }
                    
                    VStack(alignment: .center) {
                        ZStack {
                            Color.gray.opacity(0.2)
                            
                            TextField("", text: $username, prompt: Text("Username").foregroundStyle(.white.opacity(0.25)))
                        }
                        .frame(width: 200, height: 35)
                        .clipShape(.rect(cornerRadius: 10.0))
                        
                        ZStack {
                            Color.gray.opacity(0.2)
                            
                            TextField("", text: $password, prompt: Text("Password").foregroundStyle(.white.opacity(0.25)))
                        }
                        .frame(width: 200, height: 35)
                        .clipShape(.rect(cornerRadius: 10.0))
                        
                        if isSignUpViewCalled {
                            VStack {
                                ZStack {
                                    Color.gray.opacity(0.2)
                                    
                                    TextField("", text: $email, prompt: Text("E-mail").foregroundStyle(.white.opacity(0.25)))
                                }
                                .frame(width: 200, height: 35)
                                .clipShape(.rect(cornerRadius: 10.0))
                            }
                            
                            HStack {
                                Button("Do you already have an account?") {
                                    isSignUpViewCalled.toggle()
                                }
                                .frame(width: 100)
                                .foregroundStyle(.gray)
                                .padding()
                                
                                
                                NavigationLink(destination: Feed().onAppear {
                                    do {
                                        try User(username: username, password: password, email: email, avatar: "").modelContext?.save()
                                    } catch {
                                        print("Failed to create a user instance.")
                                    }
                                    
                                    isUserLoggedIn.toggle()
                                }) {
                                    Text("Sign Up")
                                        .foregroundStyle(.sunrise)
                                }
                                .buttonStyle(BorderedButtonStyle())
                                .padding()
                            }
                            
                        } else {
                            HStack {
                                Button("Don't have an account?") {
                                    isSignUpViewCalled.toggle()
                                }
                                .frame(width: 100)
                                .foregroundStyle(.gray)
                                .padding()
                                
                                NavigationLink(destination: Feed().onAppear {
                                    isUserLoggedIn.toggle()
                                }) {
                                    Text("Sign In")
                                        .foregroundStyle(.sunrise)
                                }
                                .buttonStyle(BorderedButtonStyle())
                                .padding()
                            }
                        }
                    }
                    .multilineTextAlignment(.center)
                }
                .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    SignInView(isUserLoggedIn: .constant(false))
}
