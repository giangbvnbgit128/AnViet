//
//  File.swift
//  AnViet
//
//  Created by Bui Giang on 6/11/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import Alamofire


enum NewsPostEndPoint {
    case PostNews(userId:String,token:String,image:String,content:String)
}
class AVNewsPostRouter : AVBaseRouter {

    var endpoint: NewsPostEndPoint
    
    init(endpoint: NewsPostEndPoint) {
        self.endpoint = endpoint
    }
    
    override var method: HTTPMethod{
        switch endpoint {
        case .PostNews: return .get
        }
    }
    override var path: String {
        switch endpoint {
            case .PostNews(let userId,let token,let image,let content): return "api/create_post?user_id=\(userId)&token=\(token)&image=\(image)&content=\(content)"
        }

    }
    override var parameters: APIParams {
        return nil
    }
    
    override var encoding: Alamofire.ParameterEncoding? {
        return URLEncoding()
    }
}
