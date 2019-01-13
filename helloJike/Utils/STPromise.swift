//
//  STPromise.swift
//  helloJike
//
//  Created by Maple Yin on 2019/1/13.
//  Copyright © 2019 Maple Yin. All rights reserved.
//

import Foundation

class STPromise<T> {
    
    typealias Resolve = (_ data: T) -> Void
    typealias Reject = (_ reason: Any?) -> Void
    typealias PromiseHandle = (Resolve, Reject) throws -> Void
    
    enum Status {
        case pending, fulfilled, rejected
    }
    
    var status: Status = .pending
    
    
    var resolve: Resolve?
    
    init(_ handler: @escaping PromiseHandle) {
        do {
            try handler({value in
                
            }) { reason in
                
            }
        } catch {
        
        }
    }
    
    
    func then(_ onFulfilled: @escaping Resolve, _ onRejected: Reject? = nil) {
        
    }
    
    func error() {
    }
    
    func finally() {
        
    }
}
