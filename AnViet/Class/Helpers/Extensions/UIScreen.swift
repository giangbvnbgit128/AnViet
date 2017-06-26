//
//  UIScreen.swift
//  TLSafone
//
//  Created by HoaNV-iMac on 3/8/16.
//  Copyright © 2016 TechLove. All rights reserved.
//

import Foundation
import UIKit

/**
 *  A structure of Bool to check the screen size and get width, height for kinds of iphone
 */
public struct ScreenSize {
    public static let iSIPhone4OrLess = UIDevice.current.userInterfaceIdiom == .phone && UIScreen.maxLength < 568.0
    public static let IsIPhone5 = UIDevice.current.userInterfaceIdiom == .phone && UIScreen.maxLength == 568.0
    public static let IsIPhone6 = UIDevice.current.userInterfaceIdiom == .phone && UIScreen.maxLength == 667.0
    public static let IsIPhone6P = UIDevice.current.userInterfaceIdiom == .phone && UIScreen.maxLength == 736.0
    public static let IsIPad = UIDevice.current.userInterfaceIdiom == .pad && UIScreen.maxLength == 1024.0
}
/**
 *  A structure of CGFloat to check the screen size and get width, height for kinds of iphone
 */
public struct Ratio {
    public static let widthIPhone4 = UIScreen.mainWidth / UIScreen.mainWidthIPhone4And5
    public static let widthIPhone5 = UIScreen.mainWidth / UIScreen.mainWidthIPhone4And5
    public static let widthIPhone6 = UIScreen.mainWidth / UIScreen.mainWidthIPhone6
    public static let widthIPhone6P = UIScreen.mainWidth / UIScreen.mainWidthIPhone6P

    public static let heightIPhone4 = UIScreen.mainHeight / UIScreen.mainHeightIPhone4
    public static let heightIPhone5 = UIScreen.mainHeight / UIScreen.mainHeightIPhone5
    public static let heightIPhone6 = UIScreen.mainHeight / UIScreen.mainHeightIPhone6
    public static let heightIPhone6P = UIScreen.mainHeight / UIScreen.mainHeightIPhone6P
}

/// This extesion adds some useful functions to UIScreen
public extension UIScreen {
    // MARK: - Global variables -

    /// Get the screen width
    public class var mainWidth: CGFloat {
        get {
            return UIScreen.main.fixedScreenSize().width
        }
    }

    /// Get the screen height
    public class var mainHeight: CGFloat {
        get {
            return UIScreen.main.fixedScreenSize().height
        }
    }

    /// Get the maximum screen length
    public class var maxLength: CGFloat {
        get {
            return max(mainWidth, mainHeight)
        }
    }

    /// Get the minimum screen length
    public class var minLength: CGFloat {
        get {
            return min(mainWidth, mainHeight)
        }
    }
    /// Get the screen width iPhone 4 and iPhone 5
    public class var mainWidthIPhone4And5: CGFloat {
        get {
            return 320
        }
    }
    /// Get the screen width iPhone 6
    public class var mainWidthIPhone6: CGFloat {
        get {
            return 375
        }
    }
    /// Get the screen width iPhone 6 plus
    public class var mainWidthIPhone6P: CGFloat {
        get {
            return 414
        }
    }
    /// Get the screen height iPhone 4
    public class var mainHeightIPhone4: CGFloat {
        get {
            return 480
        }
    }
    /// Get the screen height iPhone 5
    public class var mainHeightIPhone5: CGFloat {
        get {
            return 568
        }
    }
    /// Get the screen height iPhone 6
    public class var mainHeightIPhone6: CGFloat {
        get {
            return 667
        }
    }
    /// Get the screen height iPhone 6 plus
    public class var mainHeightIPhone6P: CGFloat {
        get {
            return 736
        }
    }

    // MARK: - Class functions -

    /**
    Check if the current device has a Retina display
    - returns: Returns true if it has a Retina display, false if not
    */
    public static func isRetina() -> Bool {
        //        if UIScreen.main.responds(to: #selector(UIScreen.displayLink(withTarget:selector:)(_:selector:))) &&
        if UIScreen.main.responds(to: #selector(UIScreen.displayLink(withTarget:selector:))) &&
            (UIScreen.main.scale == 2.0 || UIScreen.main.scale == 3.0) {
            return true
        } else {
            return false
        }
    }

    /**
     Check if the current device has a Retina HD display
     - returns: Returns true if it has a Retina HD display, false if not
     */
    public static func isRetinaHD() -> Bool {
//        if UIScreen.main.responds(to: #selector(UIScreen.displayLink(withTarget:selector:)(_:selector:))) && UIScreen.main.scale == 3.0 {
        if UIScreen.main.responds(to: #selector(UIScreen.displayLink(withTarget:selector:))) && UIScreen.main.scale == 3.0 {
            return true
        } else {
            return false
        }
    }

    // MARK: - Instance functions -

    /**
    Returns the fixed screen size, based on device orientation
    - returns: Returns a GCSize with the fixed screen size
    */
    public func fixedScreenSize() -> CGSize {
        let screenSize = self.bounds.size

        if NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1 &&
            UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation) {
            return CGSize(width: screenSize.height, height: screenSize.width)
        }

        return screenSize
    }

}
