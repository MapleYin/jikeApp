//
//  MediaService.swift
//  helloJike
//
//  Created by Mapleiny on 2018/1/17.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import Foundation
import Alamofire

class MediaService: STHJService {
    public static let shared = MediaService()
    
    let mediaMetaPath = "/1.0/mediaMeta/interactive"
    
    var prefetchMediaList:[Message] = []
    
    func addprefetch(messages:[Message]) {
        for (_,message) in messages.enumerated() {
            if message.video != nil {
                prefetchMediaList.append(message)
            }
        }
        startPrefetchIfNeeded()
    }
    
    func media(_ message:Message, body:[String:Any]? = nil, then: @escaping (Media?,Error?) -> Void ) {
        let url = host+mediaMetaPath
        
        let option = RequestOption(nil, query: [
            "messageId" : message.id
            ], body:body)
        post(url, oprion: option) { (dataResponse:DataResponse<Media>) in
            dataResponse.result.ifSuccess {
                if let media = dataResponse.result.value {
                    if media.next != nil {
                        self.thirdPartRequest(media, then: { (body, error) in
                            if error == nil {
                                self.media(message, body: body, then: then)
                            } else {
                                then(nil,error)
                            }
                        })
                    } else {
                        then(media,nil)
                    }
                } else {
                    then(nil,nil)
                }
            }
            
            dataResponse.result.ifFailure {
                then(nil,dataResponse.result.error)
            }
        }
    }
    
    private func thirdPartRequest(_ media:Media, then:@escaping ([String:Any]?,Error?) -> Void) {
        Alamofire.request(media.url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: media.headers).response(completionHandler: { (dataResponse) in
            if dataResponse.error == nil,
                let data = dataResponse.data {
                then(["func":media.next!,"body":data.base64EncodedString()],nil)
            } else {
                then(nil,dataResponse.error)
            }
        })
    }
    
    private func startPrefetchIfNeeded() {
        if let message = prefetchMediaList.first {
            media(message, then: { (media, error) in
                print("Prefetch success:\(message.content)")
                message.media = media
                if self.prefetchMediaList.count > 0 {
                    self.prefetchMediaList.removeFirst()
                }
                self.startPrefetchIfNeeded()
            })
        }
    }
}
