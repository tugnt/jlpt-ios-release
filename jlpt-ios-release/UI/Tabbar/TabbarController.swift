//
//  TabbarController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/16.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

class TabbarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        view.backgroundColor = .white
        let layout = UICollectionViewFlowLayout()
        let lessionController = LessonController(collectionViewLayout: layout)
        let lessionTabItem = UITabBarItem(title: "Lesson", image: Asset.lesson.image, tag: 0)
        let navController = UINavigationController(rootViewController: lessionController)
        navController.tabBarItem = lessionTabItem
        
        let profileController = StoryboardScene.Process.processController.instantiate()
        let progressController = StoryboardScene.Process.processController.instantiate()
        self.viewControllers = [createNavController("Lession", "lesson", viewController: lessionController),
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
