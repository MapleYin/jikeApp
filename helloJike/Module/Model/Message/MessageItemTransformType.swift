//
//  MessageItemTransformType.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/25.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import Foundation
import ObjectMapper

class MessageItemTransformType: TransformType {
    typealias Object = Any
    
    typealias JSON = [String:Any]
    
    
    func transformFromJSON(_ value: Any?) -> Object? {
        if let data = value as? [String:Any] {
            var result = [Recommendation]()
            if let recommendations = data["recommendations"] as? [[String:Any]] {
                for rec in recommendations {
                    if let r = Recommendation(JSON: rec) {
                        result.append(r)
                    }
                }
                return result
            }
            
            if let message = Message(JSON: data) {
                return message
            }
        }
        return nil
    }
    
    func transformToJSON(_ value: Object?) -> JSON? {
        if let recommendations = value as? [Recommendation] {
            var result = [[String:Any]]()
            for rec in recommendations {
                result.append(rec.toJSON())
            }
            return ["recommendations":result]
        }
        if let message = value as? Message {
            return message.toJSON()
        }
        return nil
    }
}
