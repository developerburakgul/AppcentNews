//
//  ViewController.swift
//  AppcentNewsApp
//
//  Created by Burak Gül on 10.01.2025.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

#Preview() {
    ViewController()
}
#Preview("Main") {
    let newsViewController: UIViewController = NewsViewController()
    let favoritesViewController: UIViewController = FavoritesViewController()
    
    var navigationVC1 = UINavigationController(
        rootViewController: newsViewController
    )
    navigationVC1.tabBarItem = UITabBarItem(
        title: "News",
        image: UIImage(systemName: "house.fill"),
        tag: 0
    )

    
    var navigationVC2 = UINavigationController(
        rootViewController: favoritesViewController
    )
    navigationVC2.tabBarItem = UITabBarItem(
        title: "Favorites",
        image: UIImage(systemName: "heart.fill"),
        tag: 1
    )
    var tabbarController: UITabBarController = UITabBarController()
    tabbarController.viewControllers = [
        navigationVC1,
        navigationVC2
    ]
    tabbarController.tabBar.backgroundColor = .white
    return tabbarController
}

#Preview("Main") {
    let newsViewController: UIViewController = NewsViewController()
    let favoritesViewController: UIViewController = FavoritesViewController()
    
    var navigationVC1 = UINavigationController(
        rootViewController: newsViewController
    )
    navigationVC1.tabBarItem = UITabBarItem(
        title: "News",
        image: UIImage(systemName: "house.fill"),
        tag: 0
    )

    
    var navigationVC2 = UINavigationController(
        rootViewController: favoritesViewController
    )
    navigationVC2.tabBarItem = UITabBarItem(
        title: "Favorites",
        image: UIImage(systemName: "heart.fill"),
        tag: 1
    )
    var tabbarController: UITabBarController = UITabBarController()
    tabbarController.viewControllers = [
        navigationVC1,
        navigationVC2
    ]
    tabbarController.tabBar.backgroundColor = .white
    return tabbarController
}
