//
//  AVNewsFeed.swift
//  AnViet
//
//  Created by Bui Giang on 6/6/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import Alamofire



enum NewsFeedEndPoint {
    case NewsFeed(userId:String,token:String,litmit:String,post_id:String)
}

class AVNewsFeedRouter: AVBaseRouter {
    
    var endpoint: NewsFeedEndPoint
    
    init(endpoint: NewsFeedEndPoint) {
        self.endpoint = endpoint
    }
    
    override var method: HTTPMethod{
        switch endpoint {
        case .NewsFeed: return .get
        }
    }
    override var path: String {
        
        switch endpoint {
        case .NewsFeed(let userId,let token,let limit,let post_id): return "api/get_list_post?user_id=\(userId)&token=\(token)&limit=\(limit)&post_id=\(post_id)"
        }
    }
    override var parameters: APIParams {
        return nil
    }
    
    override var encoding: Alamofire.ParameterEncoding? {
        return URLEncoding()
    }
}
