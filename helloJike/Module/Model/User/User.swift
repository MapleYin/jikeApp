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
    
    enum Gender: String {
        case unknown
        case male = "MALE"
        case female = "FEMALE"
        
        init(rawValue:String) {
            switch rawValue {
            case "MALE":
                self = .male
                break;
            case "FEMALE":
                self = .female
                break;
            default:
                self = .unknown
            }
        }
    }
    
    var username: String = ""
    var screenName: String = ""
    var isVerified: Bool = false
    var verifyMessage: String = ""
    var profileImageUrl: String = ""
    var bio: String = ""
    var gender: Gender = .unknown
    var following: Bool = false
    var blocking: Bool = false
    
    var statsCount: StatsCount?
    var isLoginUser: Bool?
    var preferences: Preferences?
    var mobilePhoneNumber: String?
    var areaCode: String?
    var birthday: String?
    var city: String?
    var country: String?
    var province: String?
    
    required init?(map: Map){
    }
    func mapping(map: Map) {
        username <- map["username"]
        screenName <- map["screenName"]
        isVerified <- map["isVerified"]
        verifyMessage <- map["verifyMessage"]
        profileImageUrl <- map["profileImageUrl"]
        bio <- map["bio"]
        gender <- map["gender"]
        following <- map["following"]
        blocking <- map["blocking"]
        
        statsCount <- map["statsCount"]
        isLoginUser <- map["isLoginUser"]
        preferences <- map["preferences"]
        mobilePhoneNumber <- map["mobilePhoneNumber"]
        areaCode <- map["areaCode"]
        birthday <- map["birthday"]
        city <- map["city"]
        country <- map["country"]
        province <- map["province"]
        
    }
}

