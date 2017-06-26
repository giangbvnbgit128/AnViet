//
//  UIWindow.swift
//  Koshien
//
//  Created by Nguyen Nguyen Khoi on 6/2/16.
//  Copyright © 2016 Khoi Nguyen Nguyen. All rights reserved.
//

import UIKit

public extension UIWindow {
    func visibleViewController() -> UIViewController? {
        if let rootViewController: UIViewController = self.rootViewController {
            return UIWindow.getVisibleViewControllerFrom(rootViewController)
        }
        return nil
    }
    
    class func getVisibleViewControllerFrom(_ vc:UIViewController) -> UIViewController? {
        
        if vc.isKind(of: UINavigationController.self) {
            
            if let navigationController = vc as? UINavigationController,
                let visibleVC = navigationController.visibleViewController {
                return UIWindow.getVisibleViewControllerFrom(visibleVC)
            } else {
                return nil
            }
            
        } else if vc.isKind(of: UITabBarController.self) {
            
            if let tabBarController = vc as? UITabBarController,
                let selectedVC = tabBarController.selectedViewController {
                return UIWindow.getVisibleViewControllerFrom(selectedVC)
            } else {
                return nil
            }
            
        } else {
            
            if let presentedViewController = vc.presentedViewController,
                let presentVC = presentedViewController.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(presentVC)
            } else {
                return vc;
            }
        }
    }
}
