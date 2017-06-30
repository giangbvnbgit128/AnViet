//
//  AVLoginRouter.swift
//  AnViet
//
//  Created by Bui Giang on 5/31/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import Alamofire



enum TimeLineRouterEndPoint {
    case getTimeLine(userId:String ,token:String,limit:String,postid:String)
}

class AVTimeLineRouter: AVBaseRouter {
   
    var endpoint: TimeLineRouterEndPoint
    
    init(endpoint: TimeLineRouterEndPoint) {
        self.endpoint = endpoint
    }
    
    override var method: HTTPMethod{
        switch endpoint {
         case .getTimeLine: return .get
        }
    }
    override var path: String {
        switch endpoint {
         case .getTimeLine(let userId, let token,let limit,let postid): return "api/get_list_post_of_user?user_id=\(userId)&token=\(token)&limit=\(limit)&post_id=\(postid)"
        }
    }
    override var parameters: APIParams {
        return nil
    }
    
    override var encoding: Alamofire.ParameterEncoding? {
        return URLEncoding()
    }
}
