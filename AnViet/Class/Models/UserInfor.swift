//
//  UserInfor.swift
//  AnViet
//
//  Created by Bui Giang on 5/31/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import Foundation
import ObjectMapper

class UserInfor: Mappable{
    var error:String = ""
    var host:String = ""
    var mess:String = ""
    var data:DataInfor = DataInfor()
    
    init() {
        
    }
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
       error <- map["error"]
        host <- map["host"]
        mess <- map["mess"]
        data <- map["data"]
    }
    
    
}
class DataInfor: Mappable {
    var id:String = ""
    var username:String = ""
    var password:String = ""
    var avarta:String = ""
    var name:String = ""
    var phone:String = ""
    var address:String = ""
    var email:String = ""
    var computername:String = ""
    var model:String = ""
    var token:String = ""
    
    
    init() {
        
    }
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        username <- map["username"]
        password <- map["password"]
        avarta <- map["avatar"]
        name <- map["name"]
        phone <- map["phone"]
        address <- map["address"]
        email <- map["email"]
        computername <- map["computer_name"]
        model <- map["model"]
        token <- map["token"]
    }
    
    
}
