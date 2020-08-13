//
//  TabBarProvider.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 11.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import UIKit

final class TabBarAssembly {
    
    static func assembly() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        let trendingViewController = UINavigationController(
            rootViewController: TrendingAssembly.assembly()
        )
        let viewController = UINavigationController(
            rootViewController: ViewController()
        )
        
        let trendingTabBarItem = UITabBarItem()
        trendingTabBarItem.title = "Популярное"
        trendingTabBarItem.image = UIImage(named: "trending_icon")
        
        trendingViewController.tabBarItem = trendingTabBarItem
        tabBarController.viewControllers = [viewController, trendingViewController]
        return tabBarController
    }
}
