//
//  UserInforViewController.swift
//  AnViet
//
//  Created by Bui Van Giang on 6/28/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class UserInforViewController: AVBaseViewController {

    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tftAge: UITextField!
    @IBOutlet weak var tfSex: UITextField!
    @IBOutlet weak var tfNumberPhone: UITextField!
    @IBOutlet weak var tfMail: UITextField!
    @IBOutlet weak var tfAddress: UITextField!
    
    @IBOutlet weak var btnUpdate: UIButton!
    
    var user:UserInfor = UserInfor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        MainSettingViewController.ShareInstance.blockHiddenRightItemNav = {() in
            MainSettingViewController.ShareInstance.navigationItem.rightBarButtonItem = nil
        }
        setUpData()
    }
    
    func setUpData() {
        let value:NSObject =  UserDefaults[.userInfor] as! NSObject
        let newValue = value as? [String : AnyObject]
        user = Mapper<UserInfor>().map(JSONObject: newValue)!
        
        tfName.text = user.data.name
        tfNumberPhone.text = user.data.phone
        tfMail.text = user.data.email
        tfAddress.text = user.data.address
        
        self.navigationItem.title = user.data.name
        
        self.btnUpdate.layer.cornerRadius = 4
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionUpdate(_ sender: Any) {
        self.requsetEditProfile(userId: user.data.id, token: user.data.token, age: tftAge.text ?? "", sex: tfSex.text ?? "", phone: tfNumberPhone.text ?? "", email: tfMail.text ?? "", address: tfAddress.text ?? "")
    }
    
    
    //MARK: CallAPi Login
    
    func requsetEditProfile(userId:String,token:String,age:String,sex:String,phone:String,email:String,address:String) {
        self.showLoading()
        Alamofire.request(AVUserInforSetting( endpoint: .updatePersonalInfor(userId: userId, token: token, age: age, sex: sex, phone: phone, email: email, address: address))).responseJSON { (response) in
            self.stopLoading()
            switch response.result {
            case .success(let value):
                print("============== value =\(value)")
            case .failure(_):
                print("AAAAA")
                break
            }
        }
    }
    
    
}
