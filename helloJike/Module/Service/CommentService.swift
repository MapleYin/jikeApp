//
//  CommentService.swift
//  helloJike
//
//  Created by Mapleiny on 2018/2/13.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import Foundation
import Alamofire


class CommentService: STHJService {
    
    enum CommentType {
        case message,personalUpdate
    }
    
    private let commentPath = "/1.0/messageComments/listPrimary"
    private let personalUpdateCommentsPath = "/1.0/personalUpdateComments/listPrimary"
    
    private var loadMoreKey:Any?
    
    private let messageId:String
    private let type:CommentType

    init(messageId:String, type:CommentType = .message) {
        self.messageId = messageId
        self.type = type
        super.init()
    }

    func loadComment(then: @escaping (CommentListResponse?,Error?) -> Void)  {
        let path = self.type == .message ? commentPath : personalUpdateCommentsPath
        let url = host+path
        let option = RequestOption(nil, query: nil, body:[
            "targetId": messageId,
            ])
        post(url, oprion: option) { (dataResponse:DataResponse<CommentListResponse>) in
            dataResponse.result.ifSuccess {
                if self.loadMoreKey == nil {
                    self.loadMoreKey = dataResponse.result.value?.loadMoreKey
                }
                then(dataResponse.result.value,nil)
            }
            
            dataResponse.result.ifFailure {
                then(nil,dataResponse.result.error)
            }
        }
    }
    
    func loadMoreData(then: @escaping (CommentListResponse?,Error?) -> Void)  {
        if let loadMoreKey = self.loadMoreKey {
            let url = host+commentPath
            let option = RequestOption(nil, query: nil, body:[
                "targetId": messageId,
                "loadMoreKey" : loadMoreKey,
                ])
            post(url, oprion: option) { (dataResponse:DataResponse<CommentListResponse>) in
                dataResponse.result.ifSuccess {
                    self.loadMoreKey = dataResponse.result.value?.loadMoreKey
                    then(dataResponse.result.value,nil)
                }
                
                dataResponse.result.ifFailure {
                    then(nil,dataResponse.result.error)
                }
            }
        } else {
            
            then(nil,NSError(domain: "im.maple.jiker", code: 1001, userInfo: ["reason":"No More Data"]))
        }
    }
}
