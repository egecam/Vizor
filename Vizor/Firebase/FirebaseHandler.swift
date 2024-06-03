//
//  FirebaseHandler.swift
//  Vizor
//
//  Created by Ege Çam on 3.06.2024.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
/*
func signUp(username: String, password: String, email: String, completion: @escaping (Result<Void, Error>) -> Void) {
    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
        if let error = error {
            completion(.failure(error))
        } else {
            guard let uid = authResult?.user.uid else { return }
            let db = Firestore.firestore()
            db.collection("users").document(uid).setData([
                "username": username,
                "email": email
            ]) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
    }
}
*/
