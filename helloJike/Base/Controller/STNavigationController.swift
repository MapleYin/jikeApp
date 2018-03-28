//
//  STNavigationController.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/23.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class STNavigationController: ASNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override var childViewControllerForStatusBarStyle: UIViewController? {
        return topViewController
    }
    
    override var childViewControllerForStatusBarHidden: UIViewController? {
        return topViewController
    }

}
