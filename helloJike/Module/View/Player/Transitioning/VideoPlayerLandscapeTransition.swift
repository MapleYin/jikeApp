//
//  VideoPlayerLandscapeTransition.swift
//  helloJike
//
//  Created by Maple Yin on 2018/1/29.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit

class VideoPlayerLandscapeTransition: NSObject ,UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let toVC = transitionContext.viewController(forKey: .to) as! VideoPlayerLandscapeController
        let containerView = transitionContext.containerView
        
        let finalFrame = transitionContext.finalFrame(for: toVC)
        let toView = toVC.view!
        
        containerView.addSubview(toView)
        
        let originRect = toVC.originRect
        let center = CGPoint(x: originRect.midY, y: originRect.midX)
        toView.frame = CGRect(x: center.x - originRect.width * 0.5,
                              y: center.y - originRect.height * 0.5,
                              width: originRect.width,
                              height: originRect.height)
        
        let rotate = CGFloat(-Double.pi/2)
        let tramsform = CGAffineTransform(rotationAngle: rotate)
        toView.transform = tramsform


        UIView.animate(withDuration:transitionDuration(using: transitionContext), animations: {
            toView.transform = CGAffineTransform.identity
            toView.frame = finalFrame
        }) { (finished) in
            transitionContext.completeTransition(true)
        }
    }
}
