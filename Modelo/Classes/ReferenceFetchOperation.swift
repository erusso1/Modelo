//
//  ReferenceFetchOperation.swift
//  Modelo
//
//  Created by Ephraim Russo on 11/27/19.
//

import Foundation

class ReferenceFetchOperation<T: ModelType>: Operation {
    
    let identifier: T.IdentiferType
        
    var result: Result<T, Error>? {
        
        didSet {
            
            guard result != nil else { cancel(); return }
        
            self.isFinished = true
        }
    }
    
    private var _isFinished = false
    
    override var isFinished: Bool {
        
        get { return isCancelled || (_isFinished && result != nil) }
        
        set {
            
            willChangeValue(forKey: "isFinished")
            _isFinished = newValue
            didChangeValue(forKey: "isFinished")
        }
    }
    
    init(identifier: T.IdentiferType) {
        self.identifier = identifier
    }
    
    override func main() {
        
        if isCancelled { return }
                
        if let storedModel = T.safeModelMap[identifier] {
            print("Fetch from storage")
            result = .success(storedModel)
        }
            
        else {
            
            print("Fetch from network")
            
            let identifier = self.identifier
            
            T.fetchModel(identifier: identifier) { [weak self] result in
                
                if self?.isCancelled == true { return }
                
                print("Successfully fetched from network")
                
                switch result {
                    
                case .success(let model):
                                        
                    T.storeModel(model)
                    
                    self?.result = result
                    
                case .failure: self?.result = result
                }
            }
        }
    }
}
