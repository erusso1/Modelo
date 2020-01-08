//
//  ReferenceFetchTask.swift
//  Modelo
//
//  Created by Ephraim Russo on 1/25/20.
//

import Foundation

public struct ModelReferenceFetchTask {
    
    private let operation: Operation
    
    public func cancel() { operation.cancel() }
    
    public var isCancelled: Bool { operation.isCancelled }
    
    public var isFinished: Bool { operation.isFinished }
    
    public var isExecuting: Bool { operation.isExecuting }
    
    init(operation: Operation) {
        self.operation = operation
    }
}
