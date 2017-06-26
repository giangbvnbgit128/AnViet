//
//  NSString.swift
//  TLSafone
//
//  Created by HoaNV-iMac on 3/8/16.
//  Copyright © 2016 TechLove. All rights reserved.
//

import Foundation
import UIKit

public extension NSString {

    /**
     Remove double or more duplicated spaces
     - returns: String without additional spaces
     */
    public func removeExtraSpaces() -> NSString {
        let squashed = self.replacingOccurrences(of: "[ ]+",
            with: " ",
            options: .regularExpression,
            range: NSMakeRange(0, self.length))
        return squashed.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) as NSString
    }

}
