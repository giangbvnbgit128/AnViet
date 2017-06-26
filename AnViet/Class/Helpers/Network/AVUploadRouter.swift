//
//  File.swift
//  AnViet
//
//  Created by Bui Giang on 6/11/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import Alamofire


enum PostEndPoint {
    case UploadImage
    case PostNews(userId:String,token:String,image:String,content:String)
}
class AVUploadRouter : AVBaseRouter {
    
    var endpoint: PostEndPoint
    var UrlConfig:URL?
    
    init(endpoint: PostEndPoint) {
        self.endpoint = endpoint
    }
    

    func getUrl() -> String {
        return self.baseUrl + "api/upload_image"
    }
    override var path: String {
        
        switch endpoint {
        case .PostNews(let userId,let token,let image,let content): return "api/create_post?user_id=\(userId)&token=\(token)&image=\(image)&content=\(content)"
        case .UploadImage: return "api/upload_image"
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
