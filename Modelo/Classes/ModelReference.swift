//
//  Reference.swift
//  Modelo
//
//  Created by Ephraim Russo on 1/25/20.
//

import Foundation

@propertyWrapper
public struct ModelReference<T: ModelType>: Codable, Equatable {
        
    public let wrappedValue: T.IdentiferType
    
    public init(wrappedValue: T.IdentiferType) {
        self.wrappedValue = wrappedValue
    }
    
    public var projectedValue: ModelReference<T> { self }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.singleValueContainer()
        self.wrappedValue = try container.decode(T.IdentiferType.self)
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
    
    @discardableResult
    public func resolve(completion: @escaping (Result<T, Error>) -> Void) -> ModelReferenceFetchTask {
        
        let identifier = self.wrappedValue
        
        let operation = ReferenceFetchOperation<T>(identifier: identifier)
        
        if let existingOperation = ModelReferenceFetchUtility.shared.existingReferenceFetchOperation(identifer: identifier, for: T.self), !existingOperation.isCancelled {
            
            operation.addDependency(existingOperation)
        }
        
        operation.completionBlock = {
            
            ModelReferenceFetchUtility
                .shared
                .removeReferenceFetchOperation(identifier: identifier)
            
            guard !operation.isCancelled, let result = operation.result else { return }

            DispatchQueue.main.async { completion(result) }
        }
        
        ModelReferenceFetchUtility.shared.addReferenceFetchOperation(operation, identifier: identifier)
                
        return .init(operation: operation)
    }
}

extension ModelReference {
    
    public var storedValue: T? { return T.safeModelMap[wrappedValue] }
}

public func ==<T: ModelType>(lhs: ModelReference<T>, rhs: ModelReference<T>) -> Bool {
    return lhs.wrappedValue == rhs.wrappedValue
}
