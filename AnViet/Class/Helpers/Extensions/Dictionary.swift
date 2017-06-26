//
//  Dictionary.swift
//  Koshien
//
//  Created by BAC.TRAN on 4/11/17.
//  Copyright © 2017 Khoi Nguyen Nguyen. All rights reserved.
//

import Foundation


extension Dictionary {
    
    func getFirstKey() ->String {
        let keys = Array(self.keys)
        if let firstKey = keys[0] as? String, keys.count > 0  {
            return firstKey
        }
        return ""
    }
    func getFirstValue() -> String {
        let values = Array(self.values)
        if let firstValue = values[0] as? String, values.count > 0  {
            return firstValue
        }
        return ""
    }
}
