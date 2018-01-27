//
//  MeController.swift
//  helloJike
//
//  Created by Mapleiny on 2017/12/27.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit

class MeController: STTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let user = Cache.userDefault.getUser(), !user.isLoginUser else {
            
//            self.present(LoginController(), animated: true, completion: nil)
            
            return
        }
        
        
    }
}
