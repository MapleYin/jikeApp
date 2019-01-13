//
//  GenderTransform.swift
//  helloJike
//
//  Created by Maple Yin on 2018/2/3.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import Foundation
import ObjectMapper


class GenderTransform : TransformType {

    
    typealias JSON = String
    
    
    func transformFromJSON(_ value: Any?) -> User.Gender? {
        if let gander = value as? String {
            return User.Gender(rawValue: gander)
        }
        return nil
    }
    
    func transformToJSON(_ value: User.Gender?) -> String? {
        if value != nil {
            return value?.rawValue
        }
        return nil
    }
}
