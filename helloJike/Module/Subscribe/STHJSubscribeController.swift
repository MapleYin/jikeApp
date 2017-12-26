//
//  STHJSubscribeController.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/23.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit

class STHJSubscribeController: STHJTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "订阅"
        
        
        AccountService.shared.profile()
    }
}
