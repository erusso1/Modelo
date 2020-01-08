//
//  ModelReferenceFetchUtility.swift
//  Modelo
//
//  Created by Ephraim Russo on 1/25/20.
//

import Foundation

final class ModelReferenceFetchUtility {
    
    static let shared: ModelReferenceFetchUtility = {

        return .init()
    }()
    
    private var operationQueue: OperationQueue = {
       
        var queue = OperationQueue()
        queue.name = "com.modelo.ModelReferenceFetchUtility.operationQueue"
        return queue
        
    }()
    
    @Atomic private var resolutionsInProgress: [AnyHashable: Operation] = [:]

    func existingReferenceFetchOperation<T: ModelType>(identifer: AnyHashable, for type: T.Type) -> ReferenceFetchOperation<T>? {
        
        return resolutionsInProgress[identifer] as? ReferenceFetchOperation<T>
    }
    
    func removeReferenceFetchOperation(identifier: AnyHashable) {
        
        _resolutionsInProgress.update { $0[identifier] = nil }
    }
    
    func addReferenceFetchOperation(_ operation: Operation, identifier: AnyHashable) {
        
        _resolutionsInProgress.update { $0[identifier] = operation }
        
        operationQueue.addOperation(operation)
    }
}
