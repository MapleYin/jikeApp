//
//  STJAccountManager.swift
//  helloJike
//
//  Created by Maple Yin on 2019/1/12.
//  Copyright © 2019 Maple Yin. All rights reserved.
//

import Foundation
import Alamofire
import AdSupport

class STJAccountManager {
    
    static let shared = STJAccountManager()
    
    var account: User? = STJUserDefault.shared.account
    
    
    func register(username: String? = nil , password: String? = nil, then: @escaping (Bool)->Void) {
        let uesername = NSUUID().uuidString
        let password = RandomString(16)
        let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        let registerRequest = RegisterRequest(username: uesername, password: password, idfa: idfa)
        Alamofire.request(registerRequest).responseJSON { (response) in
            if let data = response.result.value as? [String: Any],
                data["success"] as? Bool == true,
                let userInfo = data["user"] as? [String: Any] {
                
                let user = User(JSON: userInfo)
                self.account = user
                STJUserDefault.shared.account = user
                self.saveToken(headers: response.response?.allHeaderFields)
                
                then(true)
            }else {
                then(false)
            }
        }
    }
    
    func profile() {
        Alamofire.request(ProfileRequest()).responseJSON { (response) in
            if let result = response.result.value as? [String: Any] {
                if let userInfo = result["user"] as? [String: Any] {
                
                let user = User(JSON: userInfo)
                self.account = user
                STJUserDefault.shared.account = user
                } else {
                    print("\(result["error"] ?? "")")
                }
            } else {
                print("\(String(describing: response.result.error))")
            }
        }
    }
    
    
    func refreshToken(then: @escaping (Bool) -> Void) {
        Alamofire.request(TokenRefreshRequest()).responseJSON { (response) in
            if let result = response.result.value as? [String: Any] {
                if result["success"] as? Bool == true {
                    self.saveToken(headers: result)
                    then(true)
                } else {
                    then(false)
                }
            } else {
                then(false)
            }
        }
    }
    
    
    
    private func saveToken(headers: [AnyHashable: Any]?) {
        STJUserDefault.shared.accessToken = headers?["x-jike-access-token"] as? String
        STJUserDefault.shared.refreshToken = headers?["x-jike-refresh-token"] as? String
        STJHeaders.global.xJikeAccessToken = STJUserDefault.shared.accessToken
    }
    
}



extension STJAccountManager {
    func checkMobilePhoneOccupied(areaCode:String = "+86", mobilePhoneNumber:String,_ then:@escaping (_ isOccupied:Bool,_ isBindable:Bool,_ error:Error?) -> Void ) {
        
        let request = CheckMobilePhoneOccupiedRequest(mobilePhoneNumber: mobilePhoneNumber)
        
        Alamofire.request(request).responseJSON { (dataResponse) in
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
}
