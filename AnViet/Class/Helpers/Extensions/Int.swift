//
//  Int.swift
//  TLSafone
//
//  Created by HoaNV-iMac on 3/8/16.
//  Copyright © 2016 TechLove. All rights reserved.
//

import Foundation
import UIKit

extension Int {
    /// Determine if self is even (equivalent to `self % 2 == 0`)
    // Kiểm tra số chẳn, variable of Bool to check even
    public var isEven: Bool {
        return (self % 2 == 0)
    }

    /// Determine if self is odd (equivalent to `self % 2 != 0`)
    // Kiểm tra số lẻ, variable of Bool to check Odd
    public var isOdd: Bool {
        return (self % 2 != 0)
    }

    /// Determine if self is positive (equivalent to `self > 0`)
    // Kiểm tra số dương, variable of Bool to check positive
    public var isPositive: Bool {
        return (self > 0)
    }

    /// Determine if self is negative (equivalent to `self < 0`)
    // Kiểm tra số âm, variable of Bool to check negative
    public var isNegative: Bool {
        return (self < 0)
    }

    /**
     Convert self to a Double.

     Most useful when operating on Int optionals.

     For example:
     ```
     let number: Int? = 5

     // instead of
     var double: Double?
     if let number = number {
     double = Double(number)
     }

     // use
     let double = number?.toDouble
     ```
     */
    public var doubleValue: Double {
        return Double(self)
    }

    /**
     Convert self to a Float.

     Most useful when operating on Int optionals.

     For example:
     ```
     let number: Int? = 5

     // instead of
     var float: Float?
     if let number = number {
     float = Float(number)
     }

     // use
     let float = number?.toFloat
     ```
     */
    public var floatValue: Float {
        return Float(self)
    }

    /**
     Convert self to a CGFloat.

     Most useful when operating on Int optionals.

     For example:
     ```
     let number: Int? = 5

     // instead of
     var cgFloat: CGFloat?
     if let number = number {
     cgFloat = CGFloat(number)
     }

     // use
     let cgFloat = number?.toCGFloat
     ```
     */
    public var toCGFloat: CGFloat {
        return CGFloat(self)
    }

    /**
     Convert self to a String.

     Most useful when operating on Int optionals.

     For example:
     ```
     let number: Int? = 5

     // instead of
     var string: String?
     if let number = number {
     string = String(number)
     }

     // use
     let string = number?.toString
     ```
     */
    public var stringValue: String {
        return String(self)
    }

    /// Generate a random Int bounded by a closed interval range.
    public static func random(_ range: ClosedRange<Int>) -> Int {
//        return range.start + Int(arc4random_uniform(UInt32(range.end - range.start + 1)))
        return range.lowerBound + Int(arc4random_uniform(UInt32(range.lowerBound - range.upperBound + 1)))
    }

    /// Generate a random Int bounded by a range from min to max.
    public static func random(min: Int, max: Int) -> Int {
        return random(min...max)
    }

}
