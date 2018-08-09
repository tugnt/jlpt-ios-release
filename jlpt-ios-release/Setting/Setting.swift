//
//  Setting.swift
//  jlpt-ios-release
//
//  Created by t_nguyen on 2018/05/12.
//  Copyright © 2018年 Nguyen Trong Tung. All rights reserved.
//

import Foundation

struct Setting {
    static var firstRunApp: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "firstRunApp")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "firstRunApp")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var fontSize: Int {
        get {
            return UserDefaults.standard.integer(forKey: "fontSize")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "fontSize")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var coins: Int {
        get {
            return UserDefaults.standard.integer(forKey: "userCoins")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userCoins")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var isPremiumAccount: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isPremiumAccount")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isPremiumAccount")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var isAutoAppodeal: Bool {
        get {
            return UserDefaults.standard.bool(forKey: #function)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: #function)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var isAutoFacebookInterstitial: Bool {
        get {
            return UserDefaults.standard.bool(forKey: #function)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: #function)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var isAutoShowAds: Bool {
        get {
            return UserDefaults.standard.bool(forKey: #function)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: #function)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var numberNendBannerInpression: Int {
        get {
            return UserDefaults.standard.integer(forKey: #function)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: #function)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var isNendAutoLoad: Bool {
        get {
            return UserDefaults.standard.bool(forKey: #function)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: #function)
            UserDefaults.standard.synchronize()
        }
    }
}
