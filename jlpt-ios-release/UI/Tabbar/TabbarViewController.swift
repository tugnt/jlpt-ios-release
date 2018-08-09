//
//  TabbarViewController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/16.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import FontAwesome

class TabbarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        view.backgroundColor = .white
        self.tabBarController?.tabBar.tintColor = .blue
        let layout = UICollectionViewFlowLayout()
        let lessionController = LessonViewController(collectionViewLayout: layout)

        let ProfileViewController = StoryboardScene.ProfileViewController.profileViewController.instantiate()
        let progressController = StoryboardScene.ProcessViewController.processViewController.instantiate()
        let ChatRoomViewController = StoryboardScene.GroupChatViewController.groupChatViewController.instantiate()
        let DocumentViewController = StoryboardScene.DocumentsViewController.documentViewController.instantiate()
    
        let tabIconSize = CGSize(width: 30, height: 30)
        self.viewControllers = [createNavController("Bài học",
                                                    UIImage.fontAwesomeIcon(name: .graduationCap, textColor: .black, size: tabIconSize),
                                                    viewController: lessionController),
                                createNavController("Tài liệu",
                                                    UIImage.fontAwesomeIcon(name: .fileText, textColor: .black, size: tabIconSize),
                                                    viewController: DocumentViewController),
                                createNavController("Trò truyện",
                                                    UIImage.fontAwesomeIcon(name: .wechat, textColor: .black, size: tabIconSize),
                                                    viewController: ChatRoomViewController),
                                createNavController("Tài khoản",
                                                    UIImage.fontAwesomeIcon(name: .userCircleO, textColor: .black, size: tabIconSize),
                                                    viewController: ProfileViewController),
                                createNavController("Audience",
                                                    UIImage.fontAwesomeIcon(name: .areaChart, textColor: .black, size: tabIconSize),
                                                    viewController: progressController)]
    }

    private func createNavController(_ title: String, _ image: Image, viewController: UIViewController) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
