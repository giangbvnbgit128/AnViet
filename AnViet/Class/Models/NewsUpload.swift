//
//  NewsUpload.swift
//  AnViet
//
//  Created by Bui Giang on 6/27/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import ObjectMapper


class NewsUpload: Mappable {
    var error:String = "FALSE"
    var host:String = ""
    var message:String = ""
    var data:DataForNewsPost = DataForNewsPost()
    
    
    
    init() {}
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        error <- map["error"]
        host <- map["host"]
        message <- map["mess"]
        data <- map["data"]
    }
}
class DataForNewsPost: Mappable {
    var id:String = ""
    var title:String = ""
    var avatar:String = ""
    var user_id:String = ""
    var content:String = ""
    var image:String = ""
    var user_like:String = ""
    var user_view:String = ""
    var active:String = ""
    var status:String = ""
    var created_date:String = ""
    
    init() {
        
    }
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        avatar <- map["avatar"]
        user_id <- map["user_id"]
        content <- map["content"]
        image <- map["image"]
        user_like <- map["user_like"]
        user_view <- map["user_view"]
        active <- map["active"]
        status <- map["status"]
        created_date <- map["created_date"]
    }
    
    
}
