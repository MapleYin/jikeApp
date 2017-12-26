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
}

// register
// MESSAGE_RECOMMENDATION

extension AccountService {
    
    func register() {
        let url = host+registerPath
        let username = UIDevice.current.identifierForVendor?.uuidString
        request(url, method: .post, parameters: ["username":username!,"password":"3pi5rCs9f5zaSl3O"], encoding: JSONEncoding.default, headers: STHJService.COMMON_HEADER).responseJSON { (dataResponse) in
            if let result = dataResponse.result.value as? [String:Any] {
                if result["success"] as? Bool == true {
                    let userInfo = User(JSONString: result["user"] as! String);
                    self.user = userInfo
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
                let userInfo = User(JSON: result["user"] as! [String:Any] )
                self.user = userInfo;
            }
        }
    }
}
