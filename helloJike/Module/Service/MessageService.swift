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
    public static let shared = MessageService()

    private var loadMoreKey:Any?
    
    let recommendFeedListPath = "/1.0/recommendFeed/list"
}

// recommendFeed
extension MessageService {
    func recommendFeedList(_ isAuto:Bool = false , then: @escaping (MessageListReponse?,Error?) -> Void) {
        let url = host+recommendFeedListPath
        let option = RequestOption(nil, query: nil, body:[
            "limit": 10,
            "trigger": isAuto ? "auto" : "user"
            ])
        post(url, oprion: option) { (dataResponse:DataResponse<MessageListReponse>) in
            self.commendCallBack(dataResponse,then);
        }
    }
    
    func recommendFeedLoadMore(_ then: @escaping (MessageListReponse?,Error?) -> Void) {
        let url = host+recommendFeedListPath
        let option = RequestOption(nil, query: nil, body:[
            "limit": 10,
            "loadMoreKey" : self.loadMoreKey ?? [String:Any](),
            "trigger": "user"
            ])
        post(url, oprion: option) { (dataResponse:DataResponse<MessageListReponse>) in
            self.commendCallBack(dataResponse,then);
        }
    }
    
    func commendCallBack(_ dataResponse:DataResponse<MessageListReponse>, _ then: @escaping (MessageListReponse?,Error?) -> Void ) {
        dataResponse.result.ifSuccess {
            self.loadMoreKey = dataResponse.result.value?.loadMoreKey
            then(dataResponse.result.value,nil)
        }
        
        dataResponse.result.ifFailure {
            then(nil,dataResponse.result.error)
        }
    }
}
