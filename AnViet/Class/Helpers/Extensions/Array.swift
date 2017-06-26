//
//  Array.swift
//  TLSafone
//
//  Created by HoaNV-iMac on 3/8/16.
//  Copyright © 2016 TechLove. All rights reserved.
//

import Foundation

extension Array {

    func indexOfObject<T: Equatable>(_ array: Array<T>, object: T) -> Int? {
        for i in 0..<array.count {
            if array[i] == object {
                return i
            }
        }
        return nil
    }

}
