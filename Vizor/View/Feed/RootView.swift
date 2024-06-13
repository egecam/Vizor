//
//  RootView.swift
//  Vizor
//
//  Created by Ege Çam on 11.06.2024.
//

import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isUserAuthenticated: Bool = false
    
    private var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        handle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.isUserAuthenticated = user != nil
        }
    }
    
    deinit {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}


struct RootView: View {
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        if authViewModel.isUserAuthenticated {
            Feed(showSignInView: .constant(false))
        } else {
            AuthenticationView(showSignInView: .constant(true))
        }
    }
}

#Preview {
    RootView()
}
