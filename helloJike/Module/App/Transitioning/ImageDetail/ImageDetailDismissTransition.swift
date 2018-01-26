//
//  ImageDetailDismissTransition.swift
//  helloJike
//
//  Created by Mapleiny on 2018/1/26.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit

class ImageDetailDismissTransition: NSObject ,UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        
        transitionContext.completeTransition(true)
    }
    
}
