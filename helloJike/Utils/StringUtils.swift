//
//  StringUtils.swift
//  helloJike
//
//  Created by Mapleiny on 2017/12/26.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import Foundation

func RandomString(_ lengthOfString:Int) -> String {
    let charSource : NSString = "QWERTYUIOPLKJHGFDSAZXCVBNMqazxswedcvfrtgbnhyujmkiolp123456789"
    var resultString = ""
    var length = lengthOfString
    
    while length > 0 {
        let charIndex = Int(arc4random_uniform(UInt32(charSource.length)))
        var nextChar = charSource.character(at: charIndex)
        resultString += NSString(characters: &nextChar, length: 1) as String
        length -= 1
    }
    return resultString
}



func TimeString(_ time:Int) -> String {
    let minite = time / 60
    let secend:Int = Int(Float(time).truncatingRemainder(dividingBy: 60))
    return String(format: "%.2d:%.2d", minite,secend)
}
