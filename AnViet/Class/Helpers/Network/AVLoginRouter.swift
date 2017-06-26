//
//  AVLoginRouter.swift
//  AnViet
//
//  Created by Bui Giang on 5/31/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import Alamofire



enum LoginEndPoint {
    case login(userName:String ,password:String)
}

class AVLoginRouter: AVBaseRouter {
   
    var endpoint: LoginEndPoint
    
    init(endpoint: LoginEndPoint) {
        self.endpoint = endpoint
    }
    
    override var method: HTTPMethod{
        switch endpoint {
        case .login: return .get
        }
    }
    override var path: String {
        
        switch endpoint {
        case .login(let username, let password): return "api/login?username=\(username)&password=\(password)"
        }
    }
    override var parameters: APIParams {
        return nil
    }
    
    override var encoding: Alamofire.ParameterEncoding? {
        return URLEncoding()
    }
}
