//
//  NSObject.swift
//  TLSafone
//
//  Created by HoaNV-iMac on 3/8/16.
//  Copyright © 2016 TechLove. All rights reserved.
//

import Foundation

extension NSObject {
    /**
     The class name of self.

     Determines the class name of the object's dynamic type.
     */
    public var className: String {
        return type(of: self).className
    }

    /**
     The class name of Self.

     Equivalent to: `NSStringFromClass(type).componentsSeparatedByString(".").last!`
     */
    public static var className: String {
        return String.className(self)
    }

}
