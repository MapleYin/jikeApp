//
//  STJUserDefault.swift
//  helloJike
//
//  Created by Maple Yin on 2019/1/13.
//  Copyright © 2019 Maple Yin. All rights reserved.
//

import Foundation

class STJUserDefault {
    static let shared = STJUserDefault()
    
    private let userDefault = UserDefaults.standard
    
    var UUID: String? {
        set {
            self.userDefault.set(newValue, forKey: "UUID")
            self.userDefault.synchronize()
        }
        
        get {
            return self.userDefault.string(forKey: "UUID")
        }
    }
    
    
    var accessToken: String? {
        set {
            self.userDefault.set(newValue, forKey: "accessToken")
            self.userDefault.synchronize()
        }
        
        get {
            return self.userDefault.string(forKey: "accessToken")
        }
    }
    
    
    var refreshToken: String? {
        set {
            self.userDefault.set(newValue, forKey: "refreshToken")
            self.userDefault.synchronize()
        }
        
        get {
            return self.userDefault.string(forKey: "refreshToken")
        }
    }
    
    var account: User? {
        set {
            let jsonObject = newValue?.toJSON()
            self.userDefault.set(jsonObject, forKey: "User")
            self.userDefault.synchronize()
        }
        
        get {
            if let jsonObject = self.userDefault.dictionary(forKey: "User") {
                return User(JSON: jsonObject)
            }
            return nil
        }
    }
    
}
