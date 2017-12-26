//
//  STHJService.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/23.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

struct RequestOption {
    var headers:HTTPHeaders?
    var query:[String:Any]?
    var body:[String:Any]?
    
    init(_ headers:HTTPHeaders?,query:[String:Any]?, body:[String:Any]?) {
        self.headers = headers
        self.query = query
        self.body = body
    }
    
    func queryString() -> String {
        var queryElement:[String] = [];
        if let q = self.query {
            for (k,v) in q {
                queryElement.append("\(k)=\(v)")
            }
        }
        
        return "?"+queryElement.joined(separator: "&");
    }
}

func += <K, V> (left: inout [K:V], right: [K:V]) {
    for (k, v) in right {
        left[k] = v
    }
}

class STHJService {
    
    public static var COMMON_HEADER : HTTPHeaders = ["User-Agent" : "%E5%8D%B3%E5%88%BB/989 CFNetwork/893.14.2 Darwin/17.3.0",
                                              "OS-Version" : "Version 11.2.1 (Build 15C153)",
                                              "App-BuildNo" : "989",
                                              "App-Version": "3.9.1",
                                              "OS": "ios",
                                              "Model" : "iPhone10,3"];
    
    public var host = "https://app.jike.ruguoapp.com"
    
    public func get<T:BaseMappable>(_ url:String, oprion:RequestOption, then: @escaping (DataResponse<T>) -> Void) {
        var headers:HTTPHeaders = [:];
        if let customHeader = oprion.headers {
            headers += customHeader
        }
        headers += STHJService.COMMON_HEADER
        Alamofire.request(url, method: .get, parameters: oprion.query, encoding: URLEncoding.default, headers: headers).responseObject { (dataResponse:DataResponse<T>) in
            then(dataResponse)
        }
        
    }
    
    public func post<T:BaseMappable>(_ url:String, oprion:RequestOption, then: @escaping (DataResponse<T>) -> Void) {
        var headers:HTTPHeaders = [:];
        if let customHeader = oprion.headers {
            headers += customHeader
        }
        headers += STHJService.COMMON_HEADER
        
        Alamofire.request(url+oprion.queryString(), method: .post, parameters: oprion.body, encoding: URLEncoding.httpBody, headers: headers).responseObject { (dataResponse:DataResponse<T>) in
            then(dataResponse)
        };
    }
}

