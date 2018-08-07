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
import GoogleMobileAds
import Siren
import FirebaseMessaging
import UserNotifications

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
        window?.rootViewController = StoryboardScene.StartAppViewController.startAppViewController.instantiate()

        /// - Firebase
        UIApplication.shared.registerForRemoteNotifications()
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        configApplePush(application)
        /// - Google SignIn
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        
        /// Initialize the Google Mobile Ads SDK.
        GADMobileAds.configure(withApplicationID: Env.adsAppId)
        //configSiren()
        return true
    }
    
    private func configSiren() {
        let siren = Siren.shared
        siren.appName = "Luyện thi JLPT"
        siren.alertType = .force
        siren.majorUpdateAlertType = .force
        siren.forceLanguageLocalization = .vietnamese
        siren.checkVersion(checkType: .immediately)
    }

    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: [:])
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {
        //checkVersionOnWillEnterForeground()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        //checkVersionOnDidBecomeActive()
    }

    func applicationWillTerminate(_ application: UIApplication) {}
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Co chay vao day khong")
        Messaging.messaging().apnsToken = deviceToken
    }
}

//extension AppDelegate {
//    func checkVersionOnWillEnterForeground() {
//        Siren.shared.checkVersion(checkType: .immediately)
//    }
//
//    func checkVersionOnDidBecomeActive() {
//        Siren.shared.checkVersion(checkType: .immediately)
//    }
//}

extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {
    func configApplePush(_ application: UIApplication) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        if let token = Messaging.messaging().fcmToken {
            print("FCM token: \(token)")
        }
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("message")
        print(messaging)
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("didReceiveRegistrationToken")
        print(messaging)
    }
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("didRefreshRegistrationToken")
        print(messaging)
    }
}
