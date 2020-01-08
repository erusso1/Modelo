//
//  Post.swift
//  Bryce_Tests
//
//  Created by Ephraim Russo on 1/26/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import Modelo

final class Post: Codable {
    
    let id: Int
    @ModelReference<User> var user: Int
    let title: String
    let body: String
    
    init(id: Int, user: Int, title: String, body: String) {
        self.id = id
        self._user = .init(wrappedValue: user)
        self.title = title
        self.body = body
    }
}
