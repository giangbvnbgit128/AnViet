//
//  NewsItem.swift
//  AnViet
//
//  Created by Bui Giang on 6/6/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import Foundation
import ObjectMapper


class NewsItem: Mappable {
    
    var error:String = "FALSE"
    var host:String = ""
    var message:String = ""
    var data:[DataForItem] = []
    
    
    
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

class DataForItem: Mappable {
    var post:PostOfData = PostOfData()
    var user:UserNewsPost = UserNewsPost()
    
    init() {}
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        post <- map["Post"]
        user <- map["User"]
    }
}

class PostOfData: Mappable {
    
    var id:String = ""
    var title:String = ""
    var avatar:String = ""
    var userId:String = ""
    var content:String = ""
    private var strImage:String = ""
    var image:[ImageItem] = []
    var userLike:String = ""
    var userView:String = ""
    var activate:String = "0"
    var status:String = "0"
    var createdDate:String = "2017"
    
    
    init() {}
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        avatar <- map["avatar"]
        userId <- map["user_id"]
        content <- map["content"]
        strImage <- map["image"]
        userLike <- map["user_like"]
        userView <- map["user_view"]
        activate <- map["active"]
        status <- map["status"]
        createdDate <- map["created_date"]
        image = self.getArrayLinkImage(strListImage: strImage)
    }
    
    func getArrayLinkImage(strListImage: String) -> [ImageItem] {
        var arrayImage:[ImageItem] = []
        let data: Data? = strListImage.data(using: String.Encoding.utf8)
        guard data != nil else {
            return []
        }
        let json = try? JSONSerialization.jsonObject(with: data!, options:.allowFragments) as? [String : AnyObject]
        guard json != nil else {
            return []
        }
        for item in json!! {
            
            print(item.value)
            print(item.key)
            let itemImage:ImageItem = ImageItem(id: item.key, urlImage: item.value as! String)
            arrayImage.append(itemImage)
        }
        return arrayImage
    }
}

class UserNewsPost: Mappable {
    var id:String = ""
    var username:String = ""
    var avartar:String = ""
    
    init() {}
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
       id <- map["id"]
       username <- map["username"]
       avartar <- map["avatar"]
    }
}

class ImageItem: AnyObject {
    var id:String = ""
    var urlImage = ""
    
    init() {
        
    }
    
    init(id:String , urlImage:String) {
        self.id = id
        self.urlImage = urlImage
    }
    
}
