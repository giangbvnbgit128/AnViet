//
//  AVLoginRouter.swift
//  AnViet
//
//  Created by Bui Giang on 5/31/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import Alamofire



enum ChangPassEndPoint {
    case changePass(userId:String ,token:String,limit:String,postid:String)
}

class AVChangPassRouter: AVBaseRouter {
   
    var endpoint: ChangPassEndPoint
    
    init(endpoint: ChangPassEndPoint) {
        self.endpoint = endpoint
    }
    
    override var method: HTTPMethod{
        switch endpoint {
         case .changePass: return .get
        }
    }
    override var path: String {
        switch endpoint {
         case .changePass(let userId, let token,let limit,let postid): return "api/get_list_post_of_user?user_id=\(userId)&token=\(token)&limit=\(limit)&post_id=\(postid)"
        }
    }
    override var parameters: APIParams {
        return nil
    }
    
    override var encoding: Alamofire.ParameterEncoding? {
        return URLEncoding()
    }
}
