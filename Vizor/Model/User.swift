//
//  User.swift
//  Vizor
//
//  Created by Ege Çam on 2.06.2024.
//

import Foundation
import SwiftData

@Model
class User {
    var id = UUID()
    var username: String
    var password: String
    var email: String
    var avatar: String?
    var posts: [Post]?
    
    init(id: UUID = UUID(), username: String, password: String, email: String) {
        self.id = id
        self.username = username
        self.password = password
        self.email = email
    }
}
