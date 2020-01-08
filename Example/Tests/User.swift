//
//  User.swift
//  Modelo_Tests
//
//  Created by Ephraim Russo on 1/25/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import Modelo

final class User: ModelType {
    
    let id: Int
    let name: String    
    let email: String
}

extension User {
    
    static var unsafeModelMap: [Int : User] = [:]
    
    static func fetchModel(identifier: Int, completion: @escaping (Result<User, Error>) -> Void) {
    
        let request = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/users/\(identifier)")!)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else { completion(.failure(error!)); return }
            
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                completion(.success(user))
            }
            catch { completion(.failure(error)) }
        }
        task.resume()
    }
}
