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
    
    
    
    override init() {
        super.init()
        user = Cache.userDefault.getUser()
    }
}

// register
// MESSAGE_RECOMMENDATION

extension AccountService {
    
    func register(_ then: @escaping (User?,Error?) -> Void) {
        let url = host+registerPath
        let username = UIDevice.current.identifierForVendor?.uuidString
        request(url, method: .post, parameters: ["username":username!,"password":RandomString(16)], encoding: JSONEncoding.default, headers: STHJService.COMMON_HEADER).responseJSON { (dataResponse) in
            if let result = dataResponse.result.value as? [String:Any] {
                if result["success"] as? Bool == true ,
                let userInfo = result["user"] as? [String:Any]{
                    let user = User(JSON: userInfo)
                    self.user = user
                    Cache.userDefault.saveUser(user)
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
                    Cache.userDefault.saveUser(user)
                } else {
                    print("\(String(describing: result["error"]))")
                }
            }
        }
    }
}
