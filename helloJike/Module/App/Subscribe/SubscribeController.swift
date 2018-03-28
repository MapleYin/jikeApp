//
//  SubscribeController.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/23.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit
import AVKit

class SubscribeController: MessageController {

    var modelArray:[FeedMessage] = []
    var viewModelArray:[Any] = []
    var dataService:MessageService = MessageService(type: .subscribe)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "订阅"
        

    }
    
    
}
