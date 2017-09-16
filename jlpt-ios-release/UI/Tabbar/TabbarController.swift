//
//  TabbarController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/16.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

class TabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        let lessionController = LessonController(collectionViewLayout: layout)
        
        let profileController: ProfileController = (UIStoryboard(storyboard: .profile, bundle: nil).instantiateViewController(withIdentifier: String(describing: ProfileController.self)) as? ProfileController)!
        
        let progressController: ProcessController = (UIStoryboard(storyboard: .progress, bundle: nil).instantiateViewController(withIdentifier: String(describing: ProcessController.self)) as? ProcessController)!
        
        viewControllers = [createNavController("Lession", "lesson", viewController: lessionController),
                           createNavController("Progress", "process", viewController: progressController),
                           createNavController("Profile", "profile", viewController: profileController)]
    }
    
    fileprivate func createNavController(_ title: String,_ imageName: String, viewController: UIViewController) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
    }

}
