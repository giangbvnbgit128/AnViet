//
//  RegisterAccountRouter.swift
//  AnViet
//
//  Created by Bui Giang on 5/25/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import Alamofire

enum RegisEnpoint {
    case Regis(username:String,email:String,password:String, phone:String
        ,computername:String,model:String,name:String)
}

class AVRegisterAccountRouter: AVBaseRouter {
    var Enpoint:RegisEnpoint
    
    init(enpoint:RegisEnpoint) {
        self.Enpoint = enpoint
    }
    
   override var method: HTTPMethod{
    switch Enpoint {
        case .Regis: return .get
        }
    }
    override var path: String {
        switch Enpoint {
        case .Regis(let username, let email, let password, let phone, let computername, let model, let name):
            
            return "api/register?username=\(username)&password=\(password)&phone=\(phone)&computer_name=\(computername)&model=\(model)&name=\(name)&email=\(email)"
        default: break
            
        }
    }
    override var parameters: APIParams {
        return nil
    }
    
    override var encoding: Alamofire.ParameterEncoding? {
        return URLEncoding()
    }
}
