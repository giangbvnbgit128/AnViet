//
//  AVRegisterAccountAccountViewController.swift
//  AnViet
//
//  Created by Bui Giang on 5/25/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import IQKeyboardManagerSwift

class AVRegisterAccountAccountViewController: AVBaseViewController {

    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var imgErrorName: UIImageView!
    
    @IBOutlet weak var tfNumberPhone: UITextField!
    @IBOutlet weak var imgErrorNumberPhone: UIImageView!
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var imgErrorEmail: UIImageView!
    
    @IBOutlet weak var tfPassWord: UITextField!
    @IBOutlet weak var imgErrorPass: UIImageView!
    
    @IBOutlet weak var btnRegis: UIButton!
    @IBOutlet weak var tfAgaintPass: UITextField!
    @IBOutlet weak var imagErrorPassAgaint: UIImageView!
    
    @IBOutlet weak var tfForLatop: UITextField!
    
    @IBOutlet weak var tfProducer: UITextField!
    
    @IBOutlet weak var tfModel: UITextField!
    @IBOutlet weak var imgErrorModel: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var userInfor:UserInfor = UserInfor()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let lable = UILabel(frame: CGRect.zero)
        lable.text = "Đăng Ký"
        self.navigationItem.title = "Đăng Ký"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.red]
        
        self.tfName.delegate = self
        self.tfEmail.delegate = self
        self.tfModel.delegate = self
        self.tfForLatop.delegate = self
        self.tfPassWord.delegate = self
        self.tfProducer.delegate = self
        self.tfAgaintPass.delegate = self
        self.tfNumberPhone.delegate = self
        
        // config imae
        
        self.imgErrorName.isHidden = true
        self.imagErrorPassAgaint.isHidden = true
        self.imgErrorPass.isHidden = true
        self.imgErrorEmail.isHidden = true
        self.imgErrorNumberPhone.isHidden = true
        self.imgErrorModel.isHidden = true
        // Do any additional setup after loading the view.
        
        btnRegis.layer.cornerRadius = 4
        
        // config gor textfile
        
        
        
    }
    
    @IBAction func actionRegistration(_ sender: AnyObject) {

        self.checkNiltf(tf: self.tfNumberPhone)
        self.checkNiltf(tf: self.tfPassWord)
        let usename = self.tfNumberPhone.text ?? ""
        let email = self.tfEmail.text ?? ""
        let password = self.tfPassWord.text?.md5() ?? ""
        let phone = usename
        let computerName = self.tfModel.text ?? ""
        let model = self.tfModel.text ?? ""
        let name = self.tfName.text ?? ""
        self.requsetRegis(userName: usename.urlEncodeUTF8(), email: email.urlEncodeUTF8(), passWord: password, phone: phone.urlEncodeUTF8(), computerName: computerName.urlEncodeUTF8(), model: model.urlEncodeUTF8(), name: name.urlEncodeUTF8())
        
    }
    
    func checkNiltf(tf:UITextField) {
        switch tf {
        case self.tfNumberPhone:
            if self.tfNumberPhone.text == nil {
                self.showAler(message: "Error", title: "Số điện thoại không được để chống")
                return
            }
        case self.tfPassWord:
            if self.tfNumberPhone.text == nil {
                self.showAler(message: "Error", title: "Mật khẩu không được để chống")
                return
            }
        default:
            break
        }
    }
    
    @IBAction func actionShowSheet(_ sender: AnyObject) {
        self.ActionSheetChooseProducer()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    
    func ActionSheetChooseProducer() {
        
        let alertController = UIAlertController(title: nil, message: "Chọn hãng sản xuất", preferredStyle: .actionSheet)
        
        let sendButton = UIAlertAction(title: "Dell", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
        })
        
        let  deleteButton = UIAlertAction(title: "Asus", style: .destructive, handler: { (action) -> Void in
            print("Delete button tapped")
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        
        alertController.addAction(sendButton)
        alertController.addAction(deleteButton)
        alertController.addAction(cancelButton)
        
        self.navigationController!.present(alertController, animated: true, completion: nil)
    }
    
//MARK: Call Api Registransion
    
    func requsetRegis(userName:String,email:String,passWord:String,phone:String,computerName:String,
                      model:String,name:String) {
        Alamofire.request(AVRegisterAccountRouter( enpoint: .Regis(username: userName, email: email, password: passWord, phone: phone, computername: computerName, model: model, name: name))).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let newValue = value as? [String : AnyObject]
                UserDefaults[.userInfor] = value as! NSObject
                self.userInfor = Mapper<UserInfor>().map(JSONObject: newValue)!
                if self.userInfor.error.compare("FALSE") == .orderedSame {
                    
                    let value:NSObject =  UserDefaults[.userInfor] as! NSObject
                    let newValue = value as? [String : AnyObject]
                    let user = Mapper<UserInfor>().map(JSONObject: newValue)!
                    
                    let tabbarVC = AVMainViewController()
                    let anvVC = AVBaseNavigationController(rootViewController: tabbarVC)
                    appDelegate.window?.rootViewController = anvVC
                    appDelegate.window?.makeKeyAndVisible()
                } else {
                    self.showAler(message: self.userInfor.mess, title: "")
                }
            case .failure(_):
                break
            }
        }
    }
}

extension AVRegisterAccountAccountViewController: UITextFieldDelegate {

    public func textFieldDidBeginEditing(_ textField: UITextField) {    
        switch textField {
        case self.tfAgaintPass:
            self.scrollView.setContentOffset(CGPoint( x: 0, y: self.tfNumberPhone.frame.height * 2), animated: true)
        default:
            break
        }
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case self.tfName:
            if self.tfName.text == nil {
                self.tfName.text = ""
            }
            self.imgErrorName.isHidden = (self.tfName.text?.trimmingCharacters(in: .whitespaces).validate(.alphabetCharatersOnly(from: 4, to: 16)))!
            break
        case self.tfPassWord:
            if (self.tfPassWord.text == nil) {
                self.tfPassWord.text = ""
            }

            if (self.tfPassWord.text?.length)! > 8 {
                self.imgErrorPass.isHidden = false
            } else {
                self.imgErrorPass.isHidden = true
            }
            
            break
        case self.tfAgaintPass:
            if self.tfAgaintPass.text?.trimmingCharacters(in: .whitespaces).compare((self.tfPassWord.text?.trimmingCharacters(in: .whitespaces))!) == .orderedSame {
                self.imagErrorPassAgaint.isHidden = true
            } else {
                self.imagErrorPassAgaint.isHidden = false
            }
            break
        case self.tfNumberPhone:
            if self.tfNumberPhone.text == nil {
                self.tfNumberPhone.text = ""
            }
            
            self.imgErrorNumberPhone.isHidden = (self.tfNumberPhone.text?.trimmingCharacters(in: .whitespaces).validate( .numberphone(form: 10, to: 11)))!
            
            break
        case self.tfEmail:
            if self.tfEmail.text == nil {
                self.tfEmail.text = ""
            }
            
            self.imgErrorEmail.isHidden = (self.tfEmail.text?.trimmingCharacters(in: .whitespaces).validate( .email1))!
            
            break
        default: break
        }
    }
    
}
