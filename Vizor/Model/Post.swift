//
//  Post.swift
//  Vizor
//
//  Created by Ege Çam on 3.06.2024.
//

import Foundation
import SwiftData

@Model
class Post {
    var id = UUID()
    var title: String
    var image: String
    var createdBy: User
    var likes: Int
    
    init(id: UUID = UUID(), title: String, image: String, createdBy: User, likes: Int = 0) {
        self.id = id
        self.title = title
        self.image = image
        self.createdBy = createdBy
        self.likes = likes
    }
    
    func increaseLikes(likes: inout Int) -> Int {
        likes += 1
        self.likes = likes
        return self.likes
    }
}
