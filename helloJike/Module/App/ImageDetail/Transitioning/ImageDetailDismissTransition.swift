//
//  ImageDetailDismissTransition.swift
//  helloJike
//
//  Created by Mapleiny on 2018/1/26.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit

class ImageDetailDismissTransition: NSObject ,UIViewControllerAnimatedTransitioning {
    
    let animationDuration = 0.25
    
    var targetViewController:UIViewController&ImageDetailTransitionProtocol
    var sourceViewController:ImageDetailController
    
    init(target:UIViewController&ImageDetailTransitionProtocol,source:ImageDetailController) {
        self.targetViewController = target
        self.sourceViewController = source
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        if let toView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)?.view {
            container.addSubview(toView)
        }
        
        let fromView = sourceViewController.view!
        container.addSubview(fromView)
        
        
        
        if let (sourceImageView,index) = sourceViewController.currentImageView(),
            let (imageView,rect) = self.targetViewController.sourceImageView(at: index){
            let fakeImageView = ImageView()
            fakeImageView.clipsToBounds = true
            fakeImageView.contentMode = imageView.contentMode
            fakeImageView.image = sourceImageView.image
            var frame = sourceImageView.frame
            frame.origin.y = frame.origin.y + container.safeAreaInsets.top
            fakeImageView.frame = frame
            container.addSubview(fakeImageView)
            
            imageView.alpha = 0
            sourceImageView.alpha = 0

            UIView.animate(withDuration: animationDuration, animations: {
                fakeImageView.frame = rect
                fromView.alpha = 0
            }, completion: { (finished) in
                imageView.alpha = 1
                transitionContext.completeTransition(true)
            })
        } else {
            transitionContext.completeTransition(true)
        }
    }
    
}
