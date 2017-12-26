//
//  STUserDefault.swift
//  helloJike
//
//  Created by Mapleiny on 2017/12/26.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import Foundation
import ObjectMapper

class STUserDefault {
    enum SavedKey:String {
        case user = "default_user"
    }
}

extension STUserDefault {
    private func save<T:BaseMappable>(_ obj:T?, key:SavedKey) {
        if let obj = obj {
            UserDefaults.standard.set(obj.toJSON(), forKey: key.rawValue)
        }
    }
    private func read<T:BaseMappable>(key:SavedKey) -> T? {
        if let value = UserDefaults.standard.dictionary(forKey: key.rawValue) {
            return T(JSON: value)
        }
        return nil
    }
}


// User
extension STUserDefault {
    func saveUser(_ user:User?) {
        save(user, key: SavedKey.user)
    }
    
    func getUser() -> User? {
        return read(key: SavedKey.user)
    }
}
