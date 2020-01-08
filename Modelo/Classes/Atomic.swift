//
//  Atomic.swift
//  Modelo
//
//  Created by Ephraim Russo on 1/25/20.
//

import Foundation

@propertyWrapper
struct Atomic<Value> {
    
    private let queue: DispatchQueue = .init(label: "com.modelo.atomic.\(UUID().uuidString)")
    
    private var value: Value
    
    var wrappedValue: Value {
        
        get { queue.sync { value } }
        
        set { queue.sync { value = newValue } }
    }
    
    init(wrappedValue: Value) {
        self.value = wrappedValue
    }
    
    mutating func update(_ updates: (inout Value) -> Void) {
    
        queue.sync { updates(&value) }
    }
}
