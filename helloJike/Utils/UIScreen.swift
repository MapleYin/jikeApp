//
//  UIScreen.swift
//  helloJike
//
//  Created by Maple Yin on 2018/1/14.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit


extension UIScreen {
    static func chooseByWidth<T>(_ for320:T, _ for375:T, _ for414:T) -> T {
        switch main.bounds.width {
        case 320:
            return for320
        case 375:
            return for375
        case 414:
            return for414
        default:
            return for375
        }
    }
}
