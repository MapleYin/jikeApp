//
//  STJMessageManager.swift
//  helloJike
//
//  Created by Maple Yin on 2019/1/13.
//  Copyright © 2019 Maple Yin. All rights reserved.
//

import Foundation

class STJMessageManager {
    
    enum MessageServiceType {
        case recommend,subscribe
        
        func path() -> String {
            var urlString:String
            switch self {
            case .recommend:
                urlString = "/1.0/recommendFeed/list"
                break
            case .subscribe:
                urlString = "/1.0/newsFeed/list"
                break
            }
            return urlString
        }
    }
    
    private var type: MessageServiceType
    
    var loadMoreKey: [String: Any]?
    
    required init(type: MessageServiceType) {
        self.type = type
    }
}
