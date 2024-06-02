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
    
    init(id: UUID = UUID(), username: String, password: String, email: String, avatar: String?) {
        self.id = id
        self.username = username
        self.password = password
        self.email = email
        self.avatar = avatar
    }
}
