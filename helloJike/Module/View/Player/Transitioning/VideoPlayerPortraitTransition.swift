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
        
        containerView.addSubview(toView)
        containerView.addSubview(fromView)
        
        
        let player = formVC.player
        let originRect = formVC.originRect
        
        fromView.frame = originRect
        
        
        UIView.animate(withDuration:2, animations: {
            fromView.backgroundColor = UIColor(red:0.000, green:0.000, blue:0.000, alpha:0.000)
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
