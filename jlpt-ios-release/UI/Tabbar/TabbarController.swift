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
        tabBarController?.tabBar.tintColor = .blue
        let layout = UICollectionViewFlowLayout()
        let lessionController = LessonController(collectionViewLayout: layout)
        
        let profileController = StoryboardScene.Profile.profileController.instantiate()
        let progressController = StoryboardScene.Process.processController.instantiate()
        let chatRoomController = StoryboardScene.ChatRoom.chatRoomController.instantiate()
        let documentController = StoryboardScene.Documents.documentController.instantiate()
        
        self.viewControllers = [createNavController("Bài học", Asset.tabLesson.image, viewController: lessionController),
                                createNavController("Tiến độ", Asset.tabProgress.image, viewController: progressController),
                                createNavController("Tài liệu", Asset.tabDocument.image, viewController: documentController),
                                createNavController("Trò truyện", Asset.tabChat.image, viewController: chatRoomController),
                                createNavController("Tài khoản", Asset.tabProfile.image, viewController: profileController)]
    }

    
    fileprivate func createNavController(_ title: String,_ image: Image, viewController: UIViewController) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
