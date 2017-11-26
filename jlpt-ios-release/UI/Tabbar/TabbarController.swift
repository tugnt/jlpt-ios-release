//
//  TabbarController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/16.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import FontAwesome

class TabbarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        view.backgroundColor = .white
        tabBarController?.tabBar.tintColor = .blue
        let layout = UICollectionViewFlowLayout()
        let lessionController = LessonController(collectionViewLayout: layout)

        let profileController = StoryboardScene.Profile.profileController.instantiate()
        let progressController = StoryboardScene.Process.processController.instantiate()
        //let chatRoomController = ChatRoomController()
        let chatRoomController = StoryboardScene.GroupChatViewController.groupChatViewController.instantiate()
        let documentController = StoryboardScene.Documents.documentController.instantiate()
        let tabIconSize = CGSize(width: 30, height: 30)
        self.viewControllers = [createNavController("Bài học",
                                                    UIImage.fontAwesomeIcon(name: .graduationCap, textColor: .black, size: tabIconSize),
                                                    viewController: lessionController),
                                createNavController("Tiến độ",
                                                    UIImage.fontAwesomeIcon(name: .areaChart, textColor: .black, size: tabIconSize),
                                                    viewController: progressController),
                                createNavController("Tài liệu",
                                                    UIImage.fontAwesomeIcon(name: .fileText, textColor: .black, size: tabIconSize),
                                                    viewController: documentController),
                                createNavController("Trò truyện",
                                                    UIImage.fontAwesomeIcon(name: .wechat, textColor: .black, size: tabIconSize),
                                                    viewController: chatRoomController),
                                createNavController("Tài khoản",
                                                    UIImage.fontAwesomeIcon(name: .userCircleO, textColor: .black, size: tabIconSize),
                                                    viewController: profileController)]
    }

    fileprivate func createNavController(_ title: String, _ image: Image, viewController: UIViewController) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let index = tabBarController.selectedIndex
        if index == 3 { }
    }
}
