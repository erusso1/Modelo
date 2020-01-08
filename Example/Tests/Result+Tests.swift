//
//  Result+Tests.swift
//  Modelo_Tests
//
//  Created by Ephraim Russo on 1/25/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

public extension Result {
    
    var value: Success? {
        
        switch self {
        case .success(let val): return val
        default: return nil
        }
    }
    
    var error: Failure? {
        
        switch self {
        case .failure(let err): return err
        default: return nil
        }
    }
}
