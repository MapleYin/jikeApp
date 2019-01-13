//
//  AccountDataManager.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/23.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit
import Alamofire

class AccountService: STHJService {
    
    public static let shared = AccountService()
    
    var user:User?
    
    let registerPath = "/1.0/users/register"
    let profilePath = "/1.0/users/profile"
    
    let checkMobilePhoneOccupiedPath = "/1.0/users/checkMobilePhoneOccupied"
    
    let smsCodePath = "/1.0/users/getSmsCode"
    let mixLoginWithPhonePath = "/1.0/users/mixLoginWithPhone"
    
    
    
    override init() {
        super.init()
//        user = Cache.userDefault.getUser()
    }
}

// register
// MESSAGE_RECOMMENDATION

extension AccountService {
    
    func register(_ then: @escaping (User?, Error?) -> Void) {
        let url = host+registerPath
        let username = UUID().uuidString
        let idfa = UUID().uuidString
        
        request(url, method: .post, parameters: [
            "username" : username,
            "password" : RandomString(16),
            "saDeviceId" : idfa,
            "idfa" : idfa
        ], encoding: JSONEncoding.default, headers: STHJService.COMMON_HEADER).responseJSON { (dataResponse) in
            if let headers = dataResponse.response?.allHeaderFields {
                let accessToken = headers["x-jike-access-token"] as? String
                let refreshToken = headers["x-jike-refresh-token"] as? String
            }
            
            if let result = dataResponse.result.value as? [String:Any] {
                if result["success"] as? Bool == true ,
                let userInfo = result["user"] as? [String:Any]{
//                    let user = User(JSON: userInfo)
//                    self.user = user
//                    Cache.userDefault.saveUser(user)
                } else {
                    print("\(String(describing: result["error"]))")
                }
            }
        }
    }
    
    func profile() {
        let url = host+profilePath
        request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: STHJService.COMMON_HEADER).responseJSON { (dataResponse) in
            if let result = dataResponse.result.value as? [String:Any] {
                if let userInfo = result["user"] as? [String:Any] {
                    
                    let user = User(JSON: userInfo)
                    self.user = user
//                    Cache.userDefault.saveUser(user)
                } else {
                    print("\(String(describing: result["error"]))")
                }
            }
        }
    }
}


extension NSNotification.Name {
    public static let loginStatus = NSNotification.Name(rawValue: "LOGIN_OTIFICATION")
}

// login
extension AccountService {
    /*
     {
     "action": "PHONE_MIX_LOGIN",
     "areaCode": "+86",
     "mobilePhoneNumber": "18612531029"
     }
     
     {
     "areaCode": "+86",
     "mobilePhoneNumber": "18612531029"
     }
     
     {
     "success": true,
     "data": {
         "isOccupied": true,
         "isBindable": true
     }
     }
     
     */
    func checkMobilePhoneOccupied(areaCode:String = "+86", mobilePhoneNumber:String,_ then:@escaping (_ isOccupied:Bool,_ isBindable:Bool,_ error:Error?) -> Void ) {
        let url = host+checkMobilePhoneOccupiedPath
        
        request(url,
                method: .post,
                parameters: [
                    "areaCode":areaCode,
                    "mobilePhoneNumber":mobilePhoneNumber
            ], encoding: JSONEncoding.default,
               headers: STHJService.COMMON_HEADER).responseJSON { (dataResponse) in
                dataResponse.result.ifSuccess {
                    if let result = dataResponse.result.value as? [String:Any] {
                        if result["success"] as? Bool == true {
                            
                        } else {
                            print("\(String(describing: result["error"]))")
                        }
                    } else {
                        
                    }
                }
                
                dataResponse.result.ifFailure {
                    then(false,false,dataResponse.error)
                }
                
        }
    }
    
    /*
     {
         "success": true,
         "data": {
             "action": "LOGIN"
         }
     }
     */
    func smsCode(action:String, areaCode:String = "+86", mobilePhoneNumber:String,_ then:@escaping (_ isSuccess:Bool,_ reason:String?) -> Void ) {
        let url = host+smsCodePath
        request(url,
                method: .post,
                parameters: [
                    "action":action,
                    "areaCode":areaCode,
                    "mobilePhoneNumber":mobilePhoneNumber
            ], encoding: JSONEncoding.default,
               headers: STHJService.COMMON_HEADER).responseJSON { (dataResponse) in
                dataResponse.result.ifSuccess {
                    if let result = dataResponse.result.value as? [String:Any] {
                        if result["success"] as? Bool == true {
                            then(true,nil)
                        } else {
                            then(false,result["error"] as? String)
                            print("\(String(describing: result["error"]))")
                        }
                    } else {
                        then(false,"Empty result value")
                    }
                }
                
                dataResponse.result.ifFailure {
                    then(false,dataResponse.result.error?.localizedDescription)
                }
                
        }
    }
    
    func mixLoginWithPhone(smsCode:String, areaCode:String = "+86", mobilePhoneNumber:String,_ then:@escaping (_ user:User?,_ errorString:String?) -> Void) {
        let url = host+mixLoginWithPhonePath
        request(url,
                method: .post,
                parameters: [
                    "smsCode":smsCode,
                    "areaCode":areaCode,
                    "mobilePhoneNumber":mobilePhoneNumber
            ], encoding: JSONEncoding.default,
               headers: STHJService.COMMON_HEADER).responseJSON { (dataResponse) in
                dataResponse.result.ifSuccess {
                    if let result = dataResponse.result.value as? [String:Any] {
                        if let userInfo = result["user"] as? [String:Any] {
//                            let user = User(JSON: userInfo)
//                            self.user = user
//                            Cache.userDefault.saveUser(user)
//                            NotificationCenter.default.post(name: .loginStatus, object: user)
//                            then(user,nil)
                        } else if result["successs"] as? Bool == false{
                            then(nil,result["error"] as? String)
                        }
                    }
                }
                
                dataResponse.result.ifFailure {
                    then(nil,dataResponse.result.error?.localizedDescription)
                }
                
        }
    }
    
}








