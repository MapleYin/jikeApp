//
//  MessageService.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/25.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import Foundation
import Alamofire

class MessageService: STHJService {
    
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
    
    private var type:MessageServiceType
    private var loadMoreKey:Any?
    
    required init(type:MessageServiceType) {
        self.type = type
    }
}

extension MessageService {
    
    func fetch(isAuto:Bool = false , then: @escaping (MessageListReponse?,Error?) -> Void) {
        let url = host+self.type.path()
        let option = RequestOption(nil, query: nil, body:[
            "limit": 10,
            "trigger": isAuto ? "auto" : "user"
            ])
        post(url, oprion: option) { (dataResponse:DataResponse<MessageListReponse>) in
            dataResponse.result.ifSuccess {
                self.loadMoreKey = dataResponse.result.value?.loadMoreKey
                then(dataResponse.result.value,nil)
            }
            
            dataResponse.result.ifFailure {
                then(nil,dataResponse.result.error)
            }
        }
    }
    
    
    func loadMore(then: @escaping (MessageListReponse?,Error?) -> Void) {
        let url = host+self.type.path()
        let option = RequestOption(nil, query: nil, body:[
            "limit": 10,
            "loadMoreKey" : self.loadMoreKey ?? [String:Any](),
            "trigger": "user"
            ])
        post(url, oprion: option) { (dataResponse:DataResponse<MessageListReponse>) in
            dataResponse.result.ifSuccess {
                self.loadMoreKey = dataResponse.result.value?.loadMoreKey
                then(dataResponse.result.value,nil)
            }
            
            dataResponse.result.ifFailure {
                then(nil,dataResponse.result.error)
            }
        }
    }
}
