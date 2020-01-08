//
//  Comment.swift
//  Bryce_Tests
//
//  Created by Ephraim Russo on 1/26/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

final class Comment: Codable {
    
    let id: Int
    let postId: Int
    let name: String
    let email: String
    let body: String
    
    init(id: Int, postId: Int, name: String, email: String, body: String) {
        self.id = id
        self.postId = postId
        self.name = name
        self.email = email
        self.body = body
    }
}
