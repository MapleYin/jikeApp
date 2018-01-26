//
//  ImageDetailTransitionDelegate.swift
//  helloJike
//
//  Created by Mapleiny on 2018/1/26.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit

class CustomTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if presented.isKind(of: ImageDetailController.self) {
            return ImageDetailPresentTransition()
        }
        return nil
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if dismissed.isKind(of: ImageDetailController.self) {
            return ImageDetailDismissTransition()
        }
        return nil
    }
}

