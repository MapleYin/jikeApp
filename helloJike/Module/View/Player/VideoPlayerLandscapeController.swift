//
//  VideoPlayerLandscapeController.swift
//  helloJike
//
//  Created by Mapleiny on 2018/1/29.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit

class VideoPlayerLandscapeController: STViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.landscapeLeft,.landscapeRight]
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func prefersHomeIndicatorAutoHidden() -> Bool {
        return true
    }
    
}
