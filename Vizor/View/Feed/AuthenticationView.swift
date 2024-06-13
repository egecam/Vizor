//
//  AuthenticationView.swift
//  Vizor
//
//  Created by Ege Çam on 11.06.2024.
//

import SwiftUI

struct AuthenticationView: View {
    @Binding var showSignInView: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    SignInView(showSignInView: $showSignInView)
                } label: {
                    Text("Sign Up with email")
                }
            }
            .padding()
            .navigationTitle("Sign Up")
        }
    }
}

/*
struct NewAuthenticationView_Previews: PreviewProvider {
    static var preview: some View {
        NavigationStack {
            NewAuthenticationView()
        }
    }
}
*/
