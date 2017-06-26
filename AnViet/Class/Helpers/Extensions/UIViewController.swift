//
//  UIViewController.swift
//  TLSafone
//
//  Created by Nguyen Van Hoa on 3/7/16.
//  Copyright © 2016 TechLove. All rights reserved.
//

import UIKit
let appDelegate = (UIApplication.shared.delegate as? AppDelegate)!

public extension UIViewController {

    static func vc() -> Self {
        return self.init(nibName: self.className, bundle: nil)
    }
    
    var navigationBar: UINavigationBar? {
        return navigationController?.navigationBar
    }

    func backgroundThread(_ delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
            if background != nil {
                background!()
            }

            let popTime = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: popTime) {
                if completion != nil {
                    completion!()
                }
            }
        }
    }

    func showStatusBarLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    func hideStatusBarLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    func heightStatusBar() -> CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    func heightOfNavigationBar() -> CGFloat {
        if let nav = self.navigationController?.navigationBar {
            return nav.frame.height
        }
        return 0.0
    }
//    func setAutoRotate(flg:Bool) {
//        if(flg){
//            self.addAutoRotation()
//        }else{
//            if UIDevice.current.orientation.isLandscape {
//                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
//            }
//            self.removeAutoRotation()
//        }
//    }
}

extension UIViewController: BackButtonHandlerProtocol {
    //Handle back bar button
    func navigationShouldPopOnBackButton() -> Bool {
        return false
    }
}
