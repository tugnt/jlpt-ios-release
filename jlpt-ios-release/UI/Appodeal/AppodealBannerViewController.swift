//
//  AppodealBannerViewController.swift
//  jlpt-ios-release
//
//  Created by t_nguyen on 2018/08/07.
//  Copyright © 2018年 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import Appodeal


class AppodealBannerViewController: UIViewController, AppodealInterstitialDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        Appodeal.setInterstitialDelegate(self)
    }
    
    func interstitialDidLoadAdIsPrecache(_ precache: Bool){
        Appodeal.showAd(.interstitial, rootViewController: self)
        print("Interstitial was loaded")
    }
    func interstitialDidFailToLoadAd(){
        print("Interstitial failed to load")
    }
    func interstitialWillPresent(){
        print("Interstitial will present the ad")
    }
    func interstitialDidDismiss(){
        print("Interstitial was closed")
    }
    func interstitialDidClick(){
        print("Interstitial was clicked")
    }
}
