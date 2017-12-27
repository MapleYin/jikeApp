//
//  STHJTabBarController.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/23.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var tabBarViewControllers:[UIViewController] = [];
        
        // Recommend
        tabBarViewControllers.append(addViewController(RecommendController(), title: "推荐", image: #imageLiteral(resourceName: "icon_recommend"), selectedImage: #imageLiteral(resourceName: "icon_recommend")));
        
        // Subscribe
        tabBarViewControllers.append(addViewController(STHJSubscribeController(), title: "订阅", image: #imageLiteral(resourceName: "icon_subscribe"), selectedImage: #imageLiteral(resourceName: "icon_subscribe")));
        
        // Me
//        tabBarViewControllers.append(addViewController(MeController(), tabBarItem: UITabBarItem(tabBarSystemItem: .contacts, tag: 0)))
        
        
        self.viewControllers = tabBarViewControllers;

    }
    
    private func addViewController(_ viewController:UIViewController, tabBarItem:UITabBarItem) -> UIViewController{
        viewController.tabBarItem = tabBarItem;
        return STHJNavigationController(rootViewController: viewController);
    }
    
    private func addViewController(_ viewController:UIViewController, title:String, image:UIImage, selectedImage:UIImage) -> UIViewController{
        viewController.tabBarItem.title = title;
        viewController.tabBarItem.image = image;
        viewController.tabBarItem.selectedImage = image;
        return STHJNavigationController(rootViewController: viewController);
    }


}
