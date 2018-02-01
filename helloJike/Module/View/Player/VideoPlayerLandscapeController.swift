//
//  VideoPlayerLandscapeController.swift
//  helloJike
//
//  Created by Mapleiny on 2018/1/29.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit

class VideoPlayerLandscapeController: STViewController {
    
    var player:PlayerView
    var originRect:CGRect
    
    init(_ player:PlayerView, from rect:CGRect) {
        self.player = player
        self.originRect = rect
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        
        view.addSubview(player)
        
        player.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
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
