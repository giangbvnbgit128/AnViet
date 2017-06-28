//
//  AVNewsFeed.swift
//  AnViet
//
//  Created by Bui Giang on 6/6/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import Alamofire



enum UserInforSettingEndPoint {
    case updatePersonalInfor(userId:String,token:String,age:String,sex:String,phone:String,email:String,address:String)
}

class AVUserInforSetting: AVBaseRouter {
    
    var endpoint: UserInforSettingEndPoint
    
    init(endpoint: UserInforSettingEndPoint) {
        self.endpoint = endpoint
    }
    
    override var method: HTTPMethod{
        switch endpoint {
        case .updatePersonalInfor: return .get
        }
    }
    override var path: String {
        
        switch endpoint {
        case .updatePersonalInfor(let userId,let token,let age,let sex,let phone,let email,let address): return "api/edit_profile?user_id=\(userId)&token=\(token)&age=\(age)&sex=\(sex)&phone=\(phone)&email=\(email)&address=\(address)"
        }
    }
    override var parameters: APIParams {
        return nil
    }
    
    override var encoding: Alamofire.ParameterEncoding? {
        return URLEncoding()
    }
}
