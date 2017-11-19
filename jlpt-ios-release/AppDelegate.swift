//
//  AppDelegate.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/08/26.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Fabric.with([Crashlytics.self])
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        /// - Set up navigation bar
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UINavigationBar.appearance().barTintColor = ColorName.navBackground.color
        UINavigationBar.appearance().tintColor = .white
        UIApplication.shared.statusBarStyle = .lightContent
        /// - Set root controller
        window?.rootViewController = StoryboardScene.StartApp.startAppController.instantiate()

        /// - Firebase
        FirebaseApp.configure()

        /// - Google SignIn
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        return true
    }

    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }

func applicationWillResignActive(_ application: UIApplication) {}

func applicationDidEnterBackground(_ application: UIApplication) {}

func applicationWillEnterForeground(_ application: UIApplication) {}

func applicationDidBecomeActive(_ application: UIApplication) {}

func applicationWillTerminate(_ application: UIApplication) {}
}
