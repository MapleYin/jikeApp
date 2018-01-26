//
//  ImageDetailPresentTransition.swift
//  helloJike
//
//  Created by Mapleiny on 2018/1/26.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit

class ImageDetailPresentTransition: NSObject ,UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to), let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else { return }
        
        let fromView = fromViewController.view!
        let toView = toViewController.view!
        
        let container = transitionContext.containerView
        
        container.addSubview(toView)
        transitionContext.completeTransition(true)
    }
    
    
}
