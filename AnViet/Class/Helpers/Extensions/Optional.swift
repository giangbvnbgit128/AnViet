//
//  Optional.swift
//  TLSafone
//
//  Created by Nguyen Van Hoa on 3/7/16.
//  Copyright © 2016 TechLove. All rights reserved.
//

import Foundation

public extension Optional {

    func or(_ defaultValue: Wrapped) -> Wrapped {
        switch self {
        case .none:
            return defaultValue
        case .some(let value):
            return value
        }
    }

    /**
     Attempts to unwrap the optional, and executes the closure if a value exists

     - parameter block: The closure to execute if a value is found
     */
    public func unwrap(block: (Wrapped) throws -> ()) rethrows {
        if let value = self {
            try block(value)
        }
    }

    func unwrap<T1, T2>(_ optional1: T1?, optional2: T2?) -> (T1, T2)? {
        switch (optional1, optional2) {
        case let (.some(value1), .some(value2)):
            return (value1, value2)
        default:
            return nil
        }
    }

    func unwrap<T1, T2, T3>(_ optional1: T1?, optional2: T2?, optional3: T3?) -> (T1, T2, T3)? {
        switch (optional1, optional2, optional3) {
        case let (.some(value1), .some(value2), .some(value3)):
            return (value1, value2, value3)
        default:
            return nil
        }
    }

    func unwrap<T1, T2, T3, T4>(_ optional1: T1?, optional2: T2?, optional3: T3?, optional4: T4?) -> (T1, T2, T3, T4)? {
        switch (optional1, optional2, optional3, optional4) {
        case let (.some(value1), .some(value2), .some(value3), .some(value4)):
            return (value1, value2, value3, value4)
        default:
            return nil
        }
    }

    func unwrap<T1, T2, T3, T4, T5>(_ optional1: T1?, optional2: T2?, optional3: T3?, optional4: T4?, optional5: T5?) -> (T1, T2, T3, T4, T5)? {
        switch (optional1, optional2, optional3, optional4, optional5) {
        case let (.some(value1), .some(value2), .some(value3), .some(value4), .some(value5)):
            return (value1, value2, value3, value4, value5)
        default:
            return nil
        }
    }
    
    func hasValue() -> Bool {
        switch self {
        case .some: return true
        default: return false
        }
    }

}
