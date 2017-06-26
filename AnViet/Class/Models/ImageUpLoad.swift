//
//  ImageUpLoad.swift
//  AnViet
//
//  Created by Bui Giang on 6/19/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//
import UIKit
import ObjectMapper


class ImageUpload: Mappable {
    var error:String = "FALSE"
    var host:String = ""
    var message:String = ""
    var data:DataImageUpload = DataImageUpload()
    
    
    
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

class DataImageUpload: Mappable {
    var url:String = ""
    var imageId:String = ""
    
    init() {}
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        url <- map["url"]
        imageId <- map["image_id"]
    }
    
}
