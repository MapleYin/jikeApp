//
//  VideoPlayerController.swift
//  helloJike
//
//  Created by Mapleiny on 2018/1/17.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit
import AVKit

class VideoPlayerController: STViewController {

    var message:Message?
    
    required init(message:Message) {
        super.init(nibName: nil, bundle: nil)
        self.message = message
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        prepareData()
    }
    
    
    private func prepareData() {
 
    }
    
    
}
