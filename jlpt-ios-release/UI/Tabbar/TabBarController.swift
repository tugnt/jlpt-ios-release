//
//  TabBarController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/09.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeController: HomeViewController = (UIStoryboard(storyboard: .home, bundle: nil).instantiateViewController(withIdentifier: String(describing: HomeViewController.self)) as? HomeViewController)!
        
        viewControllers = [createNavController("Lession", "lesson", viewController: homeController)]
    }
    
    fileprivate func createNavController(_ title: String,_ imageName: String, viewController: UIViewController) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
    }
}
