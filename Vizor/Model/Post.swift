//
//  Post.swift
//  Vizor
//
//  Created by Ege Çam on 11.06.2024.
//

import Foundation
import FirebaseFirestoreSwift

struct Post: Identifiable, Codable {
    @DocumentID var id: String?
    var imageURL: String
    var title: String
    var timestamp: Date
    var userID: String
    
    init(imageURL: String, title: String, timestamp: Date, userID: String) {
        self.imageURL = imageURL
        self.title = title
        self.timestamp = timestamp
        self.userID = userID
    }
}

