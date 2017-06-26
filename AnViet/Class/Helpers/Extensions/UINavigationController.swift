//
//  UINavigationController.swift
//  TLSafone
//
//  Created by HoaNV-iMac on 3/18/16.
//  Copyright © 2016 TechLove. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


protocol BackButtonHandlerProtocol {
    func navigationShouldPopOnBackButton() -> Bool
}

extension UINavigationController {

    func rootViewController() -> UIViewController {
        return viewControllers.first!
    }

    func viewController(_ named: String) -> UIViewController? {
        for vc in viewControllers {
            if vc.className == named {
                return vc
            }
        }
        return nil
    }

    func viewController(index: Int) -> UIViewController? {
        if index >= 0 && index < viewControllers.count {
            return viewControllers[index]
        } else {
            return nil
        }
    }

//    func navigationBar(_ navigationBar: UINavigationBar, shouldPopItem item: UINavigationItem) -> Bool {
//        if viewControllers.count < navigationBar.items?.count {
//            return true
//        }
//
//        var shouldPop = true
//        if let topVC = self.topViewController as? BackButtonHandlerProtocol {
//            shouldPop = topVC.navigationShouldPopOnBackButton()
//        }
//        if shouldPop {
//            DispatchQueue.main.async {
//                self.popViewController(animated: true)
//            }
//        } else {
//            for view in navigationBar.subviews {
//                if view.alpha < 1.0 {
//                    [UIView.animate(withDuration: 0.25, animations: { () -> Void in
//                        view.alpha = 1.0
//                    })]
//                }
//            }
//        }
//        return false
//    }

}
