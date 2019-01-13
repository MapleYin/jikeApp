//
//  STJMessageManager+Request.swift
//  helloJike
//
//  Created by Maple Yin on 2019/1/13.
//  Copyright © 2019 Maple Yin. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Request
extension STJMessageManager {
    func fetch(isAuto: Bool = false , then: @escaping (MessageListReponse?, Error?) -> Void) {
        let request = RecommendFeedReqeust(isAuto: isAuto)
        
        Alamofire.request(request).responseObject { (dataResponse: DataResponse<MessageListReponse>) in
            dataResponse.result.ifSuccess {
                self.loadMoreKey = dataResponse.result.value?.loadMoreKey
                then(dataResponse.result.value, nil)
            }
            
            dataResponse.result.ifFailure {
                then(nil, dataResponse.result.error)
            }
        }
    }
    
    
    func loadMore(then: @escaping (MessageListReponse?, Error?) -> Void) {
        let request = RecommendFeedReqeust(loadMoreKey: self.loadMoreKey)
        
        Alamofire.request(request).responseObject { (dataResponse: DataResponse<MessageListReponse>) in
            dataResponse.result.ifSuccess {
                self.loadMoreKey = dataResponse.result.value?.loadMoreKey
                then(dataResponse.result.value, nil)
            }
            
            dataResponse.result.ifFailure {
                then(nil, dataResponse.result.error)
            }
        }
    }
}
