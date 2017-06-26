//
//  UINavigationBar.swift
//  TLSafone
//
//  Created by HoaNV-iMac on 3/8/16.
//  Copyright © 2016 TechLove. All rights reserved.
//

import UIKit

extension UINavigationBar {

    func setTransparent() {
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        isTranslucent = true
    }

    func setTitleFont(_ font: UIFont) {
        setTitleFont(font, withColor: UIColor.black)
    }

    func setTitleFont(_ font: UIFont, withColor color: UIColor) {
        var attrs = [String: AnyObject]()
        attrs[NSFontAttributeName] = font
        attrs[NSForegroundColorAttributeName] = color
        titleTextAttributes = attrs
    }

}
