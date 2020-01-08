//
//  ModelType.swift
//  Modelo
//
//  Created by Ephraim Russo on 2/8/19.
//

import Foundation

public typealias IDRepresentable = Hashable & Codable & LosslessStringConvertible

public protocol ModelType: Codable, Equatable {
    
    associatedtype IdentiferType: IDRepresentable
    
    /// Returns the unique identifier of the model object.
    var id: IdentiferType { get }
    
    /// The update queue used by this model type to safely read/write to the `unsafeModelMap`.
    static var modelMapUpdateQueue: DispatchQueue { get }
    
    /// The unsafe model hash map keybed by `identifierType` with `Self` values.
    static var unsafeModelMap: [IdentiferType: Self] { get set }
    
    /// Fetches an instance of `Self` with the given `identifer` via API request.
    static func fetchModel(identifier: IdentiferType, completion: @escaping (Result<Self, Error>) -> Void)
}

extension ModelType {
    
    public static var modelMapUpdateQueue: DispatchQueue { DispatchQueue(label: "com.Modelo.modelMapUpdateQueue.\(Self.self)", attributes: .concurrent) }
    
    public static func storeModels(_ models: [Self], completion: (()->Void)? = nil) {
        
        modelMapUpdateQueue.async(flags: .barrier) {
            
            for model in models {
                unsafeModelMap[model.id] = model
            }
            
            completion?()
        }
    }
    
    public static func storeModel(_ model: Self) {
        
        modelMapUpdateQueue.sync { unsafeModelMap[model.id] = model }
    }
    
    public static func removeAllStoredModels() {
        
        modelMapUpdateQueue.sync {
            unsafeModelMap.removeAll()
        }
    }
    
    public static var safeModelMap: [IdentiferType: Self] {
        
        var mapCopy = [IdentiferType: Self]()
        modelMapUpdateQueue.sync { mapCopy = unsafeModelMap }
        return mapCopy
    }
}

/// Equates two instances of `MTLSDKModel` by comparing their `id` properties.
public func ==<T: ModelType>(lhs: T, rhs: T) -> Bool { return lhs.id == rhs.id }
