//
//  AppDelegate+UI.swift
//  helloJike
//
//  Created by Mapleiny on 2017/12/26.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit

extension AppDelegate {
    func setupUI() {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = MainTabBarController();
        self.window?.makeKeyAndVisible();
    }
}
