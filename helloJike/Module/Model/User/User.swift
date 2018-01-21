//
//  User.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/23.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import Foundation
import ObjectMapper


class User : Mappable {
    var id:String!
    var username:String!
    var screenName:String!
    var isVerified:Bool!
    var verifyMessage:String!
    var userId:Double!
    var preferences:UserPreferences!
    var mobilePhoneNumber:String!
    var areaCode:String!
    var isLoginUser:Bool!
    var profileImageUrl:String!
    var bio:String!
    var gender:String!
    var birthday:String!
    var city:String!
    var country:String!
    var ptovince:String!
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        username <- map["username"]
        screenName <- map["screenName"]
        isVerified <- map["isVerified"]
        verifyMessage <- map["verifyMessage"]
        userId <- map["userId"]
        preferences <- map["preferences"]
        isLoginUser <- map["isLoginUser"]
    }
}

