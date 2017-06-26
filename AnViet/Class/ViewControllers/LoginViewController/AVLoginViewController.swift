//
//  AVLoginViewController.swift
//  AnViet
//
//  Created by Bui Giang on 5/25/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class AVLoginViewController: UIViewController {

    @IBOutlet weak var txtPassWord: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    
    var userInfor:UserInfor = UserInfor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Đăng Nhập"
        self.navigationController?.isNavigationBarHidden = false
        

        
        txtPassWord.text = "0988225850"
        txtUserName.text = "0988225850"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

//MARK: ActionLogin
    @IBAction func actionLogin(_ sender: AnyObject) {

        var userName = ""
        var pass = ""
        if txtUserName.text != nil {
            userName = txtUserName.text!.trimmingCharacters(in: .whitespaces)
        } else {
            // to do
        }
        
        if txtPassWord.text != nil  {
            pass = txtPassWord.text!.trimmingCharacters(in: .whitespaces)
        } else {
            // to do
        }
        self.requsetLogin(userName: userName, passWord: pass.md5())
    }
//MARK: CallAPi Login
    
    func requsetLogin(userName:String,passWord:String) {
//        self.showLoading()
        Alamofire.request(AVLoginRouter( endpoint: .login(userName: userName, password: passWord))).responseJSON { (response) in
//            self.stopLoading()
            switch response.result {
            case .success(let value):
                let newValue = value as? [String : AnyObject]
                self.userInfor = Mapper<UserInfor>().map(JSONObject: newValue)!
                UserDefaults[.userInfor] = value as! NSObject
                if self.userInfor.error.compare("FALSE") == .orderedSame {
                    let tabbarVC = AVMainViewController()
                    let anvVC = AVBaseNavigationController(rootViewController: tabbarVC)
                    appDelegate.window?.rootViewController = anvVC
                    appDelegate.window?.makeKeyAndVisible()
                } else {
                  let nameApplication = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
//                    self.showAler(message: self.userInfor.mess, title: nameApplication)
                }
            case .failure(_):
                print("AAAAA")
                break
            }
        }
    }
    
}
