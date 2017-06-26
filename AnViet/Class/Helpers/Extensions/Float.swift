//
//  Float.swift
//  TLSafone
//
//  Created by HoaNV-iMac on 3/8/16.
//  Copyright © 2016 TechLove. All rights reserved.
//

import Foundation

extension Float {
    /// Generate a random Float bounded by a closed interval range.
    public static func random(_ range: ClosedRange<Float>) -> Float {
//        return Float(arc4random()) / Float(UInt64(UINT32_MAX)) * (range.end - range.start) + range.start
        return Float(arc4random()) / Float(UInt64(UINT32_MAX)) * (range.upperBound - range.lowerBound) + range.lowerBound
    }

    /// Generate a random Float bounded by a range from min to max.
    public static func random(min: Float, max: Float) -> Float {
        return random(min...max)
    }

}
