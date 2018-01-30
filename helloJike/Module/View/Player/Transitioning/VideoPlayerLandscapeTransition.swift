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
        toView.frame = finalFrame
        
        let originRect = toVC.originRect
        
        let scale = toVC.originRect.width / finalFrame.width
        let translate = CGPoint(x: finalFrame.midX - originRect.midY, y: finalFrame.midY - originRect.midX)
        let rotate = -Double.pi/2
        
        let tramsform = CGAffineTransform(a: scale*CGFloat(cos(rotate)), b: scale*CGFloat(sin(rotate)), c: scale*CGFloat(-sin(rotate)), d: scale*CGFloat(cos(rotate)), tx: -translate.x, ty: -translate.y)
        
        toView.transform = tramsform
        
        toView.backgroundColor = UIColor(red:0.000, green:0.000, blue:0.000, alpha:0.000)
        
        containerView.addSubview(toView)

        UIView.animate(withDuration:2, animations: {
            toView.transform = CGAffineTransform.identity
            toView.backgroundColor = UIColor(red:0.000, green:0.000, blue:0.000, alpha:1.000)
        }) { (finished) in
            transitionContext.completeTransition(true)
        }
    }
}
