//
//  DefaultDateTransform.swift
//  helloJike
//
//  Created by Maple Yin on 2018/1/21.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import Foundation
import ObjectMapper


class DefaultDateTransform : TransformType {
    
    typealias Object = Date
    typealias JSON = String
    
    static let dataFormat = DateFormatter(withFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", locale: "en_US_POSIX")
    
    
    func transformFromJSON(_ value: Any?) -> Date? {
        if let date = value as? String {
            return DefaultDateTransform.dataFormat.date(from: date)
        }
        return nil
    }
    
    func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            return DefaultDateTransform.dataFormat.string(from: date)
        }
        return nil
    }
}
