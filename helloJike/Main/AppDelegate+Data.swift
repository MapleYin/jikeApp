//
//  AppDelegate+Data.swift
//  helloJike
//
//  Created by Mapleiny on 2017/12/26.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import Foundation

extension AppDelegate {
    func registIfNeeded(_ then: @escaping (Bool)->Void ) {
        if AccountService.shared.user == nil {
            AccountService.shared.register({ (user, error) in
                if user != nil {
                    then(true)
                } else {
                    then(false)
                }
            })
        } else {
            then(true)
        }
    }
    
    func updateProfile() {
        STJAccountManager.shared.register { (success) in
            
        }
        
        
        return
        registIfNeeded { (isRegist) in
            if isRegist {
                AccountService.shared.profile()
            }
        }
    }
}
