//
//  UITabBarController.swift
//  Koshien
//
//  Created by HoaNV-iMac on 3/11/16.
//  Copyright © 2016 Khoi Nguyen Nguyen. All rights reserved.
//

import Foundation
import UIKit
extension UITabBarController {
    
    func enableAtItem(_ status: Bool = true, atIndex index: Int = 0) {
        let item = self.tabBar.items![index]
        item.isEnabled = status
    }

}
