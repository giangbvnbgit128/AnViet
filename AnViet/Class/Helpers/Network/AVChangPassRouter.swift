//
//  AVLoginRouter.swift
//  AnViet
//
//  Created by Bui Giang on 5/31/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import Alamofire



enum ChangePassEndPoint {
    case changePass(userId:String ,token:String,currentPass:String,newPass:String)
}

class AVChangPassRouter: AVBaseRouter {
   
    var endpoint: ChangePassEndPoint
    
    init(endpoint: ChangePassEndPoint) {
        self.endpoint = endpoint
    }
    
    override var method: HTTPMethod{
        switch endpoint {
         case .changePass: return .get
        }
    }
    override var path: String {
        switch endpoint {
         case .changePass(let userId, let token,let currentPass,let newPass): return "api/change_password?user_id=\(userId)&token=\(token)&password=\(currentPass)&new_password=\(newPass)"
        }
    }
    override var parameters: APIParams {
        return nil
    }
    
    override var encoding: Alamofire.ParameterEncoding? {
        return URLEncoding()
    }
}
