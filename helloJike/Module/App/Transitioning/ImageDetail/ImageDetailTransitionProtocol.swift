//
//  ImageDetailTransitionProtocol.swift
//  helloJike
//
//  Created by Maple Yin on 2018/1/27.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit


protocol ImageDetailTransitionProtocol {
    func sourceImageView(at index:Int) -> (ImageView,CGRect)?
}
