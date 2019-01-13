//
//  STHJService.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/23.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit
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
    
    public static var COMMON_HEADER : HTTPHeaders = [
        "User-Agent" : "%E5%8D%B3%E5%88%BB/1328 CFNetwork/975.0.3 Darwin/18.2.0",
        "OS-Version" : "Version 12.1 (Build 16B92)",
        "App-BuildNo" : "1328",
        "App-Version": "4.15.2",
        "OS": "ios",
        "Model" : "iPhone10,3",
        "x-jike-device-id": UIDevice.current.identifierForVendor?.uuidString ?? ""
    ];
    
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
        
        Alamofire.request(url+oprion.queryString(), method: .post, parameters: oprion.body, encoding: JSONEncoding.default, headers: headers).responseObject { (dataResponse:DataResponse<T>) in
            then(dataResponse)
        };
    }
}

