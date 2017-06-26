//
//  UIColor.swift
//  TLSafone
//
//  Created by Nguyen Van Hoa on 3/7/16.
//  Copyright © 2016 TechLove. All rights reserved.
//

import UIKit

public extension UIColor {
    convenience init(hex: String) {
        self.init(hex: hex, alpha: 1)
    }

    convenience init(hex: String, alpha: CGFloat) {
        var hexWithoutSymbol = hex
        if hexWithoutSymbol.hasPrefix("#") {
            hexWithoutSymbol = hex.subString(from: 1)
        }

        let scanner = Scanner(string: hexWithoutSymbol)
        var hexInt: UInt32 = 0x0
        scanner.scanHexInt32(&hexInt)

        var red: UInt32!, green: UInt32!, blue: UInt32!

        switch hexWithoutSymbol.length {
        case 3: // #RGB
            red = ((hexInt >> 4) & 0xf0 | (hexInt >> 8) & 0x0f)
            green = ((hexInt >> 0) & 0xf0 | (hexInt >> 4) & 0x0f)
            blue = ((hexInt << 4) & 0xf0 | hexInt & 0x0f)
            break
        case 6: // #RRGGBB
            red = (hexInt >> 16) & 0xff
            green = (hexInt >> 8) & 0xff
            blue = hexInt & 0xff
            break
        default:
            break
        }

        self.init(
            red: (CGFloat(red)/255),
            green: (CGFloat(green)/255),
            blue: (CGFloat(blue)/255),
            alpha: alpha)
    }

    /// Returns a random UIColor with hue, saturation, and brightness ranging from 0.5 to 1.0.
    public static func randomColor() -> UIColor {
        let component = { CGFloat(arc4random() % 128)/256.0 + 0.5 }
        return UIColor(hue: component(), saturation: component(), brightness: component(), alpha: 1)
    }

    static func mainColor() -> UIColor {
        return UIColor(hex: "#FFFFFF")
    }

    static func rgb(_ red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: (CGFloat(red)/255.0), green: (CGFloat(green)/255.0), blue: (CGFloat(blue)/255.0), alpha: alpha)
    }

    static func kosLightBlueColor() -> UIColor {
        return UIColor(hex: "#103471")
    }

    static func kosDarkBlueColor() -> UIColor {
        return UIColor(hex: "#051f49")
    }

    static func kosOriginColor() -> UIColor {
        return UIColor(hex: "#ff690b")
    }

    static func kosLightGrayColor() -> UIColor {
        return UIColor(hex: "#e5e5e5")
    }

    static func kosDarkGrayColor() -> UIColor {
        return UIColor(hex: "#666666")
    }

    static func kosUnSelectedGrayColor() -> UIColor {
        return UIColor(hex: "#CCCCCC")
    }

}
