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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Fabric.with([Crashlytics.self])
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let rootController: StartAppController = UIStoryboard(storyboard: .startApp).instantiateViewController(withIdentifier: "StartAppController") as! StartAppController
        window?.rootViewController = TabbarController()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {}
    
    func applicationDidEnterBackground(_ application: UIApplication) {}
    
    func applicationWillEnterForeground(_ application: UIApplication) {}
    
    func applicationDidBecomeActive(_ application: UIApplication) {}
    
    func applicationWillTerminate(_ application: UIApplication) {}
}
