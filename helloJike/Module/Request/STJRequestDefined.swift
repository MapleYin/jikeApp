//
//  STJRequestDefined.swift
//  helloJike
//
//  Created by Maple Yin on 2019/1/12.
//  Copyright © 2019 Maple Yin. All rights reserved.
//

import Foundation

let Scheme = "https"
let Host = "app.jike.ruguoapp.com"

private func createUrl(path: String) -> URL {
    
    return URL(string: "\(Scheme)://\(Host)\(path)")!
}

// Register Request
func RegisterRequest(username: String, password: String, idfa: String?) -> URLRequest {
    let urlPath = "/1.0/users/register"
    let url = createUrl(path: urlPath)
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"
    urlRequest.allHTTPHeaderFields = STJHeaders.global.serialize()
    let params = [
        "saDeviceId": idfa,
        "idfa": idfa,
        "username": username,
        "password": password
    ]
    urlRequest.httpBody = params.data()
    
    return urlRequest
}


// Profile Request
func ProfileRequest() -> URLRequest {
    let urlPath = "/1.0/users/profile"
    let url = createUrl(path: urlPath)
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    urlRequest.allHTTPHeaderFields = STJHeaders.global.serialize()
    
    return urlRequest
}



// Token refresh Request
func TokenRefreshRequest() -> URLRequest {
    let urlPath = "/1.0/app_auth_tokens.refresh"
    let url = createUrl(path: urlPath)
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"
    let params:[String: String] = [:]
    var headers = STJHeaders.global
    headers.xJikeRefreshToken = STJUserDefault.shared.refreshToken
    urlRequest.allHTTPHeaderFields = headers.serialize()
    urlRequest.httpBody = params.data()
    
    return urlRequest
}


// checkMobilePhoneOccupied Request
func CheckMobilePhoneOccupiedRequest(areaCode: String = "+86",
                                     mobilePhoneNumber: String) -> URLRequest {
    let urlPath = "/1.0/users/checkOccupied"
    let url = createUrl(path: urlPath)
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"
    let params = [
        "method" : "phone",
        "areaCode" : areaCode,
        "mobilePhoneNumber" : mobilePhoneNumber
    ]
    urlRequest.allHTTPHeaderFields = STJHeaders.global.serialize()
    urlRequest.httpBody = params.data()
    
    return urlRequest
}


// RecommendFeed Reqeust
func RecommendFeedReqeust(isAuto: Bool = false, loadMoreKey: Any? = nil) -> URLRequest {
    let urlPath = "/1.0/recommendFeed/list"
    let url = createUrl(path: urlPath)
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"
    var params: [String : Any] = [
        "limit" : 10,
        "trigger": isAuto ? "auto" : "user"
    ]
    params["loadMoreKey"] = loadMoreKey
    urlRequest.allHTTPHeaderFields = STJHeaders.global.serialize()
    urlRequest.httpBody = params.data()
    
    return urlRequest
}





// Media Request
func MediaRequest(messageId: String, type: String) -> URLRequest {
    let urlPath = "/1.0/mediaMeta/interactive?id=\(messageId)&type=\(type)&trigger=auto"
    let url = createUrl(path: urlPath)
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"
    urlRequest.allHTTPHeaderFields = STJHeaders.global.serialize()
    
    
    return urlRequest
}
