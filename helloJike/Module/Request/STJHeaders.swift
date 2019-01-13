//
//  STJHeaders.swift
//  helloJike
//
//  Created by Maple Yin on 2019/1/12.
//  Copyright © 2019 Maple Yin. All rights reserved.
//

import UIKit

struct STJHeaders {
    
    static var global: STJHeaders = {
        var headers = STJHeaders()
        
        // os
        headers.os = "ios"
        headers.manufacturer = "Apple"
        headers.model = UIDevice.current.model
        headers.osVersion = "Version \(UIDevice.current.systemVersion) (Build \(Sysctl.osVersion))"
        headers.userAgent = "%E5%8D%B3%E5%88%BB/1392 CFNetwork/976 Darwin/18.2.0"
        
        headers.acceptLanguage = "zh-cn"
        headers.acceptEncoding = "br, gzip, deflate"
        headers.contentType = "application/json"
        
        headers.bundleId = "com.ruguoapp.jike"
        headers.appVersion = "5.3.0"
        headers.appBuildNo = 1392
        
        headers.kingCardStats = "unknown"
        
        headers.xJikeAccessToken = STJUserDefault.shared.accessToken
        
        
        headers.wifiConnected = false
        
        // deviceId
        if let uuid = STJUserDefault.shared.UUID {
            headers.xJikeDeviceId = uuid
        } else {
            let uuid = NSUUID().uuidString
            STJUserDefault.shared.UUID = uuid
            headers.xJikeDeviceId = uuid
        }
        
        return headers
    }()
    
    private var headers: [String: String] = [:]
    
    var os: String? {
        didSet {
            self.headers["os"] = os
        }
    }
    
    var manufacturer: String? {
        didSet {
            self.headers["manufacturer"] = manufacturer
        }
    }
    
    var model: String? {
        didSet {
            self.headers["model"] = model
        }
    }
    
    var osVersion: String? {
        didSet {
            self.headers["os-version"] = osVersion
        }
    }
    
    
    var acceptLanguage: String? {
        didSet {
            self.headers["accept-language"] = acceptLanguage
        }
    }
    
    var acceptEncoding: String? {
        didSet {
            self.headers["accept-encoding"] = acceptEncoding
        }
    }
    
    var contentType: String? {
        didSet {
            self.headers["content-type"] = contentType
        }
    }
    
    var bundleId: String? {
        didSet {
            self.headers["bundleid"] = bundleId
        }
    }
    
    var appVersion: String? {
        didSet {
            self.headers["app-version"] = appVersion
        }
    }
    
    var appBuildNo: Int? {
        didSet {
            if let appBuildNo = appBuildNo {
                self.headers["app-buildno"] = "\(appBuildNo)"
            }
        }
    }
    
    
    var userAgent: String? {
        didSet {
            self.headers["user-agent"] = userAgent
        }
    }
    
    
    var wifiConnected: Bool?  {
        didSet {
            if let wifiConnected = wifiConnected {
                self.headers["wificonnected"] = "\(wifiConnected)"
            }
        }
    }
    
    
    
    var xJikeAccessToken: String? {
        didSet {
            self.headers["x-jike-access-token"] = xJikeAccessToken
        }
    }
    
    var xJikeRefreshToken: String? {
        didSet {
            self.headers["x-jike-refresh-token"] = xJikeRefreshToken
        }
    }
    
    var xJikeDeviceId: String? {
        didSet {
            self.headers["x-jike-device-id"] = xJikeDeviceId
        }
    }
    
    var kingCardStats: String? {
        didSet {
            self.headers["king-card-status"] = xJikeDeviceId
        }
    }


    func serialize() -> [String: String] {
        return self.headers
    }
}
