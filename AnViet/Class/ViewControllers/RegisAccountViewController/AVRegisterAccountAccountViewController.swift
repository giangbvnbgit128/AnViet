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
//import IQKeyboardManagerSwift

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
    var arrayValidate:[Bool] = [false,false,false,false,false] // false ngia la validate dang sai
    
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
        let password = self.tfPassWord.text ?? ""
        let againtPass = self.tfAgaintPass.text ?? ""
        let phone = usename
        let computerName = self.tfModel.text ?? ""
        let model = self.tfModel.text ?? ""
        let name = self.tfName.text ?? ""
        
        self.checkValidateTextFeild(textField: self.tfNumberPhone)
        self.checkValidateTextFeild(textField: self.tfName)
        self.checkValidateTextFeild(textField: self.tfEmail)
        self.checkValidateTextFeild(textField: self.tfPassWord)
        self.checkValidateTextFeild(textField: self.tfAgaintPass)
        
        if self.arrayValidate[0] == false  {
            if name.characters.count == 0 {
             self.showAler(message: "Chưa nhập họ tên", title: "Lỗi")
            } else {
             self.showAler(message: "Nhập sai họ tên", title: "Lỗi")
            }
            
        } else if self.arrayValidate[1] == false {
            if usename.characters.count == 0 {
                self.showAler(message: "Chưa nhập số điện thoại", title: "Lỗi")
            } else {
                self.showAler(message: "Nhập sai số điện thoại", title: "Lỗi")
            }
            
        } else if self.arrayValidate[2] == false {
            if email.characters.count == 0 {
                self.showAler(message: "Chưa nhập Email", title: "Lỗi")
            } else {
                self.showAler(message: "Nhập sai Email", title: "Lỗi")
            }

        } else if self.arrayValidate[4] == false {
            if password.characters.count == 0 {
                self.showAler(message: "Chưa nhập mật khẩu", title: "Lỗi")
            } else {
                self.showAler(message: "Nhập sai mật khẩu", title: "Lỗi")
            }

        } else if self.arrayValidate[3] == false {
            if againtPass.characters.count == 0 {
                self.showAler(message: "Chưa nhập lại mật khẩu", title: "Lỗi")
            } else {
                self.showAler(message: "Nhập sai mật khẩu", title: "Lỗi")
            }
            
        } else {
            self.requsetRegis(userName: usename.urlEncodeUTF8(), email: email.urlEncodeUTF8(), passWord: password.md5(), phone: phone.urlEncodeUTF8(), computerName: computerName.urlEncodeUTF8(), model: model.urlEncodeUTF8(), name: name.urlEncodeUTF8())
        }
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
            self.tfProducer.text = "Dell"
        })
        
        let  deleteButton = UIAlertAction(title: "Asus", style: .destructive, handler: { (action) -> Void in
            self.tfProducer.text = "Asus"
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
                self.userInfor = Mapper<UserInfor>().map(JSONObject: newValue)!
                if self.userInfor.error.compare("FALSE") == .orderedSame {
                    AVDatamanager.ShareInstance.UserManager = self.userInfor
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
        self.checkValidateTextFeild( textField: textField)
    }
    func checkValidateTextFeild(textField: UITextField) {
        switch textField {
        case self.tfName:
            if self.tfName.text == nil {
                self.tfName.text = ""
            }
            self.imgErrorName.isHidden = (self.tfName.text?.trimmingCharacters(in: .whitespaces).validateNameVI(to: 100, form: 4))!
            arrayValidate[0] = self.imgErrorName.isHidden
            break
        case self.tfPassWord:
            if (self.tfPassWord.text == nil) {
                self.tfPassWord.text = ""
            }
            
            if (self.tfPassWord.text?.length)! > 4 {
                self.imgErrorPass.isHidden = true
            } else {
                self.imgErrorPass.isHidden = false
            }
            self.arrayValidate[4] = self.imgErrorPass.isHidden
        case self.tfAgaintPass:
            if self.tfAgaintPass.text?.trimmingCharacters(in: .whitespaces).compare((self.tfPassWord.text?.trimmingCharacters(in: .whitespaces))!) == .orderedSame {
                self.imagErrorPassAgaint.isHidden = true
            } else {
                self.imagErrorPassAgaint.isHidden = false
            }
            self.arrayValidate[3] = self.imagErrorPassAgaint.isHidden
        case self.tfNumberPhone:
            if self.tfNumberPhone.text == nil {
                self.tfNumberPhone.text = ""
            }
            
            self.imgErrorNumberPhone.isHidden = (self.tfNumberPhone.text?.trimmingCharacters(in: .whitespaces).validate( .numberphone(form: 10, to: 11)))!
            self.arrayValidate[1] = self.imgErrorNumberPhone.isHidden
            
            break
        case self.tfEmail:
            if self.tfEmail.text == nil {
                self.tfEmail.text = ""
            }
            
            self.imgErrorEmail.isHidden = (self.tfEmail.text?.trimmingCharacters(in: .whitespaces).validate( .email1))!
            self.arrayValidate[2] = self.imgErrorEmail.isHidden
            
            break
        default: break
        }
    }
}
