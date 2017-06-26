//
//  NSNotificationCenter.swift
//  Koshien
//
//  Created by HoaNV-iMac on 3/10/16.
//  Copyright © 2016 Khoi Nguyen Nguyen. All rights reserved.
//

import UIKit
let kNotification = NotificationCenter.default

extension NotificationCenter {

    class func postNotificationName(_ name: String) {
        `default`.post(name: Notification.Name(rawValue: name), object: nil)
    }

    class func postNotificationName(_ name: String, userInfo: [AnyHashable: Any]?) {
        `default`.post(name: Notification.Name(rawValue: name), object: nil, userInfo: userInfo)
    }
}
