//
//  AuthenticationManager.swift
//  Vizor
//
//  Created by Ege Çam on 3.06.2024.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
    }
}

final class AuthenticationManager {
    static let shared = AuthenticationManager()
    private init() { }
    
    // Oturum açmış bir kullanıcı varsa AuthDataResultModel döndürür, yoksa nil döndürür
    func getAuthenticatedUser() throws -> AuthDataResultModel? {
        guard let user = Auth.auth().currentUser else {
            return nil
        }
        
        return AuthDataResultModel(user: user)
    }
    
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    @discardableResult
    func signIn(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
