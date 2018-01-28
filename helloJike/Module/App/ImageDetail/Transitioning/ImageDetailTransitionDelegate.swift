//
//  ImageDetailTransitionDelegate.swift
//  helloJike
//
//  Created by Mapleiny on 2018/1/26.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit

class ImageDetailTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    var targetViewController:ImageDetailController?
    var sourceViewController:(UIViewController&ImageDetailTransitionProtocol)?
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if presented is ImageDetailController,
            source is ImageDetailTransitionProtocol {
            targetViewController = (presented as! ImageDetailController)
            sourceViewController = (source as! ImageDetailTransitionProtocol&UIViewController)
            return ImageDetailPresentTransition(target: targetViewController!, source: sourceViewController!)
        }
        return nil
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if dismissed.isKind(of: ImageDetailController.self) {
            return ImageDetailDismissTransition(target: sourceViewController!, source: targetViewController!)
        }
        return nil
    }
}

