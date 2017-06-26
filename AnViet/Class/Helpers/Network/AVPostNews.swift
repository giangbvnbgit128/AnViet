//
//  File.swift
//  AnViet
//
//  Created by Bui Giang on 6/11/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import Alamofire


enum NewsEndPoint {
    case News(userId:String,token:String,litmit:String,post_id:String)
}
class AVNewsRouter : AVBaseRouter {

    var endpoint: NewsEndPoint
    
    init(endpoint: NewsEndPoint) {
        self.endpoint = endpoint
    }
    
    override var method: HTTPMethod{
        switch endpoint {
        case .News: return .get
        }
    }
    override var path: String {
        
        switch endpoint {
        case .News(let userId,let token,let litmit,let post_id): return "api/get_list_post?user_id=\(userId)&token=\(token)&litmit=\(litmit)&post_id=\(post_id)"
        }
    }
    override var parameters: APIParams {
        return nil
    }
    
    override var encoding: Alamofire.ParameterEncoding? {
        return URLEncoding()
    }
}
