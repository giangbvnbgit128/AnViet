//
//  CGFloat.swift
//  TLSafone
//
//  Created by HoaNV-iMac on 3/8/16.
//  Copyright © 2016 TechLove. All rights reserved.
//

import UIKit

public extension CGFloat {
    /// Generate a random CGFloat bounded by a closed interval range.
    public static func random(_ range: ClosedRange<CGFloat>) -> CGFloat {
//        return CGFloat(arc4random()) / CGFloat(UInt64(UINT32_MAX)) * (range.end - range.start) + range.start
        return CGFloat(arc4random()) / CGFloat(UInt64(UINT32_MAX)) * (range.upperBound - range.lowerBound) + range.lowerBound
    }

    /// Generate a random CGFloat bounded by a range from min to max.
    public static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random(min...max)
    }
}
