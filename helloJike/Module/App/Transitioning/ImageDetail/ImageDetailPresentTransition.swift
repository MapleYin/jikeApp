//
//  ImageDetailPresentTransition.swift
//  helloJike
//
//  Created by Mapleiny on 2018/1/26.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit

class ImageDetailPresentTransition: NSObject ,UIViewControllerAnimatedTransitioning {
    
    let animationDuration = 0.2
    
    var targetViewController:ImageDetailController
    var sourceViewController:UIViewController&ImageDetailTransitionProtocol
    
    init(target:ImageDetailController,source:UIViewController&ImageDetailTransitionProtocol) {
        self.targetViewController = target
        self.sourceViewController = source
    }
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let toView = targetViewController.view!
        let container = transitionContext.containerView
        container.addSubview(toView)
        
        if let (destImageView,index) = targetViewController.currentImageView(),
            let (imageView,rect) = self.sourceViewController.sourceImageView(at: index) {
            let fakeImageView = ImageView()
            fakeImageView.contentMode = imageView.contentMode
            fakeImageView.clipsToBounds = true
            fakeImageView.image = imageView.image
            fakeImageView.frame = rect
            container.addSubview(fakeImageView)
            
            imageView.alpha = 0
            destImageView.alpha = 0
            
            toView.alpha = 0
            UIView.animate(withDuration: animationDuration, animations: {
                fakeImageView.frame = destImageView.frame
                toView.alpha = 1
            }, completion: { (finished) in
                imageView.alpha = 1
                destImageView.alpha = 1
                fakeImageView.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
        } else {
            transitionContext.completeTransition(true)
        }
    }
    
    
}
