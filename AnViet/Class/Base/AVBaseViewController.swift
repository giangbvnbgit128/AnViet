//
//  AVBaseViewController.swift
//  AnViet
//
//  Created by Bui Giang on 5/25/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import ZKProgressHUD

class AVBaseViewController: UIViewController{
    class var identifier: String { return String.className(self) }
    var indicator:UIActivityIndicatorView =  UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(indicator)
        self.view.bringSubview(toFront: indicator)
        self.indicator.backgroundColor = UIColor.clear
        self.indicator.frame = CGRect( x: UIScreen.main.bounds.width/2 - 25, y: UIScreen.main.bounds.height/2 - 25 - self.heightStatusBar() - 55, width: 50, height: 50)
        
    }
    
    func isHiddenNavigationBar(isHidden:Bool) {
        self.navigationController?.isNavigationBarHidden = isHidden
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    func showLoading() {
        self.view.bringSubview(toFront: indicator)
        self.indicator.startAnimating()
    }
    func stopLoading() {
        self.view.sendSubview(toBack: indicator)
        self.indicator.stopAnimating()
    }
    func showAler(message:String,title:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    // MARK: - Setup
    func setRightBarIconParent() {
        let leftButton = UIButton(type: .custom)
            leftButton.addTarget(self, action: #selector(self.clickRightButtom), for: .touchUpInside)
            leftButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
            leftButton.setImage(UIImage(named: "top_add"), for: .normal)
            leftButton.contentMode = .scaleAspectFit
        let leftView = UIView(x: 0, y: 0, width: 32, height: 32)
            leftView.addSubview(leftButton)
            MainSettingViewController.ShareInstance.navigationItem.setRightBarButton(UIBarButtonItem(customView: leftView), animated: false)
//                navigationItem.setRightBarButton(UIBarButtonItem(customView: leftView), animated: false)
        
    }
    
    func clickRightButtom()  {
        
    }
}
