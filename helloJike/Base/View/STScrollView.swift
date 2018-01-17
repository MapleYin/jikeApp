//
//  STScrollView.swift
//  helloJike
//
//  Created by Maple Yin on 2018/1/17.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit

class STScrollView: UIScrollView {
    
    var fitOnSizeChange:Bool
    var upscaleToFitOnSizeChange:Bool
    var stickToBounds:Bool
    var centerZoomingView:Bool
    let viewForZooming:UIView
    let doubleTapGestureRecognizer:UITapGestureRecognizer
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
