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
    
    let itemType:MessageItem.itemType
    
    init(_ itemType:MessageItem.itemType) {
        self.itemType = itemType
    }
    
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
            if itemType == .messageRecommend ||
                itemType == .message {
                if let message = FeedMessage(JSON: data) {
                    return message
                }
            } else if itemType == .personalUpdate {
                if let message = UserMessage(JSON: data) {
                    return message
                }
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
        if let message = value as? FeedMessage {
            return message.toJSON()
        } else if let message = value as? UserMessage {
            return message.toJSON()
        }
        return nil
    }
}
