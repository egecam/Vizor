//
//  SignUpView.swift
//  Vizor
//
//  Created by Ege Çam on 3.06.2024.
//

import SwiftUI
import SwiftData

struct SignInView: View {
    @Binding var isUserLoggedIn: Bool
    @State var isSignUpViewCalled: Bool = true
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("Email or password is empty.")
            return
        }
        
        try await AuthenticationManager.shared.createUser(email: email, password: password)
    }
    
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
                        /* ZStack {
                            Color.gray.opacity(0.2)
                            
                            TextField("", text: $username, prompt: Text("Username").foregroundStyle(.white.opacity(0.25)))
                        }
                        .frame(width: 200, height: 35)
                        .clipShape(.rect(cornerRadius: 10.0))
                        */
                        
                        VStack {
                            ZStack {
                                Color.gray.opacity(0.2)
                                
                                TextField("", text: $email, prompt: Text("E-mail").foregroundStyle(.white.opacity(0.25)))
                            }
                            .frame(width: 200, height: 35)
                            .clipShape(.rect(cornerRadius: 10.0))
                            
                            
                            ZStack {
                                Color.gray.opacity(0.2)
                                
                                TextField("", text: $password, prompt: Text("Password").foregroundStyle(.white.opacity(0.25)))
                            }
                            .frame(width: 200, height: 35)
                            .clipShape(.rect(cornerRadius: 10.0))
                        }
                        if isSignUpViewCalled {
                            HStack {
                                Button("Already have an account?") {
                                    isSignUpViewCalled.toggle()
                                }
                                .frame(width: 100)
                                .foregroundStyle(.gray)
                                .padding()
                                
                                // MARK: SIGN UP BUTTON
                                NavigationLink(destination: Feed(isUserLoggedIn: $isUserLoggedIn).onAppear {
                                    Task {
                                        do {
                                            try await signUp()
                                            isUserLoggedIn = true
                                        } catch {
                                            
                                        }
                                    }
                                    
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
                                
                                // MARK: SIGN IN BUTTON
                                NavigationLink(destination: Feed(isUserLoggedIn: $isUserLoggedIn).onAppear {
                                    isUserLoggedIn = true
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
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    SignInView(isUserLoggedIn: .constant(false))
}
