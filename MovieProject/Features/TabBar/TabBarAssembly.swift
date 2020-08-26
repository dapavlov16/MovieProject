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
        let favoritesViewController = UINavigationController(
            rootViewController: FavoritesAssembly.assembly()
        )
        let searchViewController = UINavigationController(
            rootViewController: SearchAssembly.assembly()
        )
        
        let trendingTabBarItem = UITabBarItem()
        trendingTabBarItem.title = "Популярное"
        trendingTabBarItem.image = UIImage(named: "trending_icon")
        trendingViewController.tabBarItem = trendingTabBarItem
        
        let favoritesTabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        favoritesViewController.tabBarItem = favoritesTabBarItem
        
        let searchTabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 3)
        searchViewController.tabBarItem = searchTabBarItem
        
        tabBarController.viewControllers = [
            trendingViewController,
            favoritesViewController,
            searchViewController
        ]
        return tabBarController
    }
}
