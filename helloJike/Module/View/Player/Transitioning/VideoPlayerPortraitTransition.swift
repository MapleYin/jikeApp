//
//  VideoPlayerPortraitTransition.swift
//  helloJike
//
//  Created by Maple Yin on 2018/1/30.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit

class VideoPlayerPortraitTransition: NSObject ,UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let formVC = transitionContext.viewController(forKey: .from) as! VideoPlayerLandscapeController
        let toVC = transitionContext.viewController(forKey: .to)!
        let containerView = transitionContext.containerView
        
        let fromView = formVC.view!
        let toView = toVC.view!
        
        toView.frame = transitionContext.finalFrame(for: toVC)
        
        let player = formVC.player
        let originRect = formVC.originRect
        
        containerView.addSubview(toView)
        containerView.addSubview(fromView)
        
        fromView.frame = transitionContext.finalFrame(for: formVC)
        
        let rotate = CGFloat(Double.pi/2)
        let tramsform = CGAffineTransform(rotationAngle: rotate)
        fromView.transform = tramsform
        
    
        UIView.animate(withDuration:transitionDuration(using: transitionContext), animations: {
            fromView.transform = CGAffineTransform.identity
            fromView.frame = originRect
            fromView.layoutIfNeeded()
        }) { (finished) in
            if let superView = player.portraitParentView {
                superView.addSubview(player)
                player.snp.makeConstraints({ (make) in
                    make.edges.equalTo(superView)
                })
            }
            transitionContext.completeTransition(true)
        }
    }
}
