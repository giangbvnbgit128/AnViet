//
//  AVChangePasswordViewController.swift
//  AnViet
//
//  Created by Bui Giang on 7/1/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class AVChangePasswordViewController: AVBaseViewController {
    @IBOutlet weak var tfcurrentPass: UITextField!
    @IBOutlet weak var tfNewPass: UITextField!
    @IBOutlet weak var tfNewPassAgaint: UITextField!
    var user:UserInfor = UserInfor()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        user = AVDatamanager.ShareInstance.UserManager
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionChangeApi(_ sender: Any) {
      
        let currentPass = tfcurrentPass.text?.trimmingCharacters(in: .whitespaces).md5()
        let newPass = tfNewPass.text?.trimmingCharacters(in: .whitespaces).md5()
        
        if self.tfNewPass.text?.compare(self.tfNewPassAgaint.text!) == .orderedSame {
            self.requsetLogin(userId: user.data.id, token: user.data.token, passWord: currentPass!, newPass: newPass!)
        } else {
            self.showAler(message: "Mật khẩu mới không giống nhau!", title: "Lỗi")
        }

    }
    
    func requsetLogin(userId:String,token:String,passWord:String,newPass:String) {
        self.showLoading()
        Alamofire.request(AVChangPassRouter( endpoint: .changePass(userId: userId, token: token, currentPass: passWord, newPass: newPass))).responseJSON { (response) in
            self.stopLoading()
            switch response.result {
            case .success(let value):
                let newValue = value as? [String : AnyObject]
                let userInfor = Mapper<UserInfor>().map(JSONObject: newValue)!
                let nameApplication = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
                self.showAler(message: userInfor.mess, title: nameApplication)
            case .failure(_):
                print("AAAAA")
                break
            }
        }
    }
}
