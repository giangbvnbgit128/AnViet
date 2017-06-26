//
//  Double.swift
//  TLSafone
//
//  Created by HoaNV-iMac on 3/8/16.
//  Copyright © 2016 TechLove. All rights reserved.
//

import Foundation

extension Double {
    /// Generate a random Double bounded by a closed interval range.
    public static func random(_ range: ClosedRange<Double>) -> Double {
//        return Double(arc4random()) / Double(UInt64(UINT32_MAX)) * (range.end - range.start) + range.start
        return Double(arc4random()) / Double(UInt64(UINT32_MAX)) * (range.upperBound - range.lowerBound) + range.lowerBound
    }

    /// Generate a random Double bounded by a range from min to max.
    public static func random(min: Double, max: Double) -> Double {
        return random(min...max)
    }
}
