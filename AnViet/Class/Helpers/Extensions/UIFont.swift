//
//  Fonts.swift
//  EParkRelax
//
//  Created by DaoNV on 3/7/16.
//  Copyright © 2016 AsianTech Inc. All rights reserved.
//

import Foundation
import UIKit
struct Font {
    static var HiraKakuProN = HiraKakuProNFont()
    static var HiraKakuPro = HiraKakuProFont()
    
    static func preloads(_ completion: (() -> Void)?) {
        dp_background { () -> Void in
            HiraKakuProN.W6(12)
            completion?()
        }
    }
}

class HiraKakuProFont: CustomFont {
    override var name: FontName! {
        return .HiraKakuPro
    }
    
    func W3(_ fontSize: CGFloat) -> UIFont! {
        return CCFont(name, .W3, fontSize)
    }
    
    func W6(_ fontSize: CGFloat) -> UIFont! {
        return CCFont(name, .W6, fontSize)
    }
}

class HiraKakuProNFont: CustomFont {
    override var name: FontName! {
        return .HiraKakuProN
    }
    
    func W3(_ fontSize: CGFloat) -> UIFont! {
        return CCFont(name, .W3, fontSize)
    }
    
    func W6(_ fontSize: CGFloat) -> UIFont! {
        return CCFont(name, .W6, fontSize)
    }
}

// MARK: - Custom Font Table
/*
 Example: label.font = Font(.Lato, .Bold, 12)
 */
enum FontName: String {
    case HiraKakuPro = "HiraKakuPro"
    case HiraKakuProN = "HiraKakuProN"
    
    var familyName: String {
        switch self {
        case .HiraKakuPro:
            return "Hiragino Kaku Gothic Pro"
        case .HiraKakuProN:
            return "Hiragino Kaku Gothic ProN"
        }
    }
}

enum FontType: String {
    case Black = "-Black"
    case BlackItalic = "-BlackItalic"
    case Bold = "-Bold"
    case BoldItalic = "-BoldItalic"
    case ExtraBold = "-ExtraBold"
    case ExtraBoldItalic = "-ExtraBoldItalic"
    case Hairline = "-Hairline"
    case HairlineItalic = "-HairlineItalic"
    case Heavy = "-Heavy"
    case HeavyItalic = "-HeavyItalic"
    case Italic = "-Italic"
    case Light = "-Light"
    case LightItalic = "-LightItalic"
    case Medium = "-Medium"
    case MediumItalic = "-MediumItalic"
    case Regular = "-Regular"
    case Semibold = "-Semibold"
    case SemiboldItalic = "-SemiboldItalic"
    case Thin = "-Thin"
    case ThinItalic = "-ThinItalic"
    case Ultra = "-Ultra"
    case W3 = "-W3"
    case W6 = "-W6"
}

enum PSDFontScale: CGFloat {
    case phone45 = 0.9
    case phone6 = 1.0
    case phone6p = 1.2
    case iPad = 1.3
}

let fontScale = loadFontScale()

func loadFontScale() -> CGFloat {
    if UIDevice.isiPad() {
        return PSDFontScale.iPad.rawValue
    } else {
        return Ratio.widthIPhone6
    }
}

func CCFont(_ name: FontName, _ type: FontType, _ size: CGFloat) -> UIFont! {
    let fontName = name.rawValue + type.rawValue
    let fontSize = size * fontScale
    let font = UIFont(name: fontName, size: fontSize)
    if let font = font {
        return font
    } else {
        print("\(fontName) is invalid font.")
        return UIFont.systemFont(ofSize: fontSize)
    }
}

class CustomFont {
    var name: FontName! { return nil }
    init() { }
    var description: String {
        if let name = name {
            let fonts = UIFont.fontNames(forFamilyName: name.familyName)
            return "\(fonts)"
        }
        return ""
    }
}
