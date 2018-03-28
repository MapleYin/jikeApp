//
//  STHJTabBarController.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/23.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class MainTabBarController: ASTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var tabBarViewControllers:[UIViewController] = [];
        
        // Recommend
        tabBarViewControllers.append(addViewController(RecommendController(), title: "推荐", image: #imageLiteral(resourceName: "icon_recommend"), selectedImage: #imageLiteral(resourceName: "icon_recommend")));
        
        // Subscribe
        tabBarViewControllers.append(addViewController(SubscribeController(), title: "订阅", image: #imageLiteral(resourceName: "icon_subscribe"), selectedImage: #imageLiteral(resourceName: "icon_subscribe")));
        
        // Me
        tabBarViewControllers.append(addViewController(MeController(), tabBarItem: UITabBarItem(tabBarSystemItem: .contacts, tag: 0)))
        
        
        viewControllers = tabBarViewControllers
        tabBar.tintColor = UIColor.mainBlue
    }
    
    private func addViewController(_ viewController:UIViewController, tabBarItem:UITabBarItem) -> UIViewController{
        viewController.tabBarItem = tabBarItem;
        return STNavigationController(rootViewController: viewController);
    }
    
    private func addViewController(_ viewController:UIViewController, title:String, image:UIImage, selectedImage:UIImage) -> UIViewController{
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        viewController.tabBarItem.selectedImage = image
        
        return STNavigationController(rootViewController: viewController);
    }


}
