//
//  SignInView.swift
//  Vizor
//
//  Created by Ege Çam on 11.06.2024.
//

import SwiftUI

@MainActor
final class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String? = nil
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else  {
            errorMessage = "No email of password found."
            return
        }
        
        do {
            try await AuthenticationManager.shared.createUser(email: email, password: password)
        } catch {
            errorMessage = error.localizedDescription
        }
        
        
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else  {
            errorMessage = "No email or password found."
            return
        }
        
        do {
            try await AuthenticationManager.shared.signIn(email: email, password: password)
        } catch {
            errorMessage = error.localizedDescription
        }
        
        
    }
}

struct SignInView: View {
    @StateObject private var viewModel = SignInViewModel()
    @State private var signUpCalled: Bool = true
    
    @Binding var showSignInView: Bool
    
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
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
                        VStack {
                            ZStack {
                                Color.gray.opacity(0.2)
                                
                                TextField("", text: $viewModel.email, prompt: Text("E-mail").foregroundStyle(.white.opacity(0.25)))
                            }
                            .frame(width: 200, height: 35)
                            .clipShape(.rect(cornerRadius: 10.0))
                            
                            ZStack {
                                Color.gray.opacity(0.2)
                                
                                TextField("", text: $viewModel.password, prompt: Text("Password").foregroundStyle(.white.opacity(0.25)))
                            }
                            .frame(width: 200, height: 35)
                            .clipShape(.rect(cornerRadius: 10.0))
                        }
                        
                        if signUpCalled {
                            HStack {
                                Button("Already have an account?") {
                                    signUpCalled.toggle()
                                }
                                .frame(width: 100)
                                .foregroundStyle(.gray)
                                .padding()
                                
                                // MARK: SIGN UP BUTTON
                                Button {
                                    Task {
                                        do {
                                            try await viewModel.signUp()
                                            showSignInView = false
                                            return
                                        } catch {
                                            
                                        }
                                    }
                                } label: {
                                    Text("Sign Up")
                                }
                                .foregroundStyle(.sunrise)
                                
                                .buttonStyle(BorderedButtonStyle())
                                .padding()
                            }
                            
                        } else {
                            HStack {
                                Button("Don't have an account?") {
                                    signUpCalled.toggle()
                                }
                                .frame(width: 100)
                                .foregroundStyle(.gray)
                                .padding()
                                
                                // MARK: SIGN IN BUTTON
                                
                                Button {
                                    Task {
                                        do {
                                            try await viewModel.signIn()
                                            showSignInView = false
                                            return
                                        } catch {
                                            
                                        }
                                    }
                                } label: {
                                    Text("Sign In")
                                }
                                .foregroundStyle(.sunrise)
                                .buttonStyle(BorderedButtonStyle())
                                .padding()
                            }
                            .foregroundStyle(.white)
                            
                            if let errorMessage = viewModel.errorMessage {
                                Text(errorMessage).foregroundStyle(.red)
                            }
                        }
                    }
                    .multilineTextAlignment(.center)
                }
                .foregroundStyle(.white)
            }
        }
        .padding()
        .navigationBarBackButtonHidden()
        .background(.black)
    }
}

#Preview {
    SignInView(showSignInView: .constant(false))
}
