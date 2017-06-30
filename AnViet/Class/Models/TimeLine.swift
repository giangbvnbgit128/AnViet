//
//  TimeLine.swift
//  AnViet
//
//  Created by Bui Van Giang on 6/30/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import ObjectMapper

class Timeline: Mappable {
    var error:String = "FALSE"
    var host:String = ""
    var mess:String = ""
    var data:dataTimeLine = dataTimeLine()
    init() {
        
    }
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        error <- map["error"]
        host <- map["host"]
        mess <- map["mess"]
        data <- map["data"]
    }
}

class dataTimeLine: Mappable {
    var User:DataInfor = DataInfor()
    var Post:[PostTimeLine] = []
    
    init() {
        
    }
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        User <- map["User"]
        Post <- map["Post"]
    }
}

class PostTimeLine: Mappable {
    var date:String = ""
    var post_data:[PostOfData] = []
    
    init() {
        
    }
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        date <- map["date"]
        post_data <- map["post_data"]
    }
}
