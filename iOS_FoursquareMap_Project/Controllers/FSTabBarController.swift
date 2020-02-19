//
//  TabBarVC.swift
//  iOS_FoursquareMap_Project
//
//  Created by Alex 6.1 on 2/19/20.
//  Copyright © 2020 aglegaspi. All rights reserved.
//

import UIKit

class FSTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemPurple
        viewControllers = [createSearchNC(),createFavoritesNC()]
    }
    
    func createSearchNC() -> UINavigationController {
        let searchvc = SearchVC()
        searchvc.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass.circle"), tag: 0)
        searchvc.title = "Search"
        return UINavigationController(rootViewController: searchvc)
    }
    
    func createFavoritesNC() -> UINavigationController {
        let collectionsvc = CollectionsVC()
        collectionsvc.tabBarItem = UITabBarItem(title: "Collections", image: UIImage(systemName: "folder"), tag: 1)
        collectionsvc.title = "Search"
        return UINavigationController(rootViewController: collectionsvc)
    }
    
}
