//
//  AppodealInterstitialViewController.swift
//  jlpt-ios-release
//
//  Created by t_nguyen on 2018/08/10.
//  Copyright © 2018年 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import Appodeal
import GoogleMobileAds
import FBAudienceNetwork

class AppodealInterstitialViewController: UIViewController, AppodealInterstitialDelegate {
    private var adsIsFinished: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Appodeal"
        //Appodeal.initialize(withApiKey: <#T##String#>, types: <#T##AppodealAdType#>, hasConsent: <#T##Bool#>)
        Appodeal.setInterstitialDelegate(self)
    }
    
    @IBAction func facebookInterstitialControler(_ sender: Any) {
        let vc = StoryboardScene.FacebookInterstitialViewController.facebookInterstitialViewController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func interstitialDidLoadAdisPrecache(_ precache: Bool){
        NSLog("Interstitial was loaded")
        Appodeal.showAd(.interstitial, rootViewController: self)
    }
    func interstitialDidFailToLoadAd(){
        NSLog("Interstitial failed to load")
    }
    func interstitialWillPresent(){
        NSLog("Interstitial will present the ad")
    }
    func interstitialDidDismiss(){
        NSLog("Interstitial was closed")
    }
    func interstitialDidClick(){
        NSLog("Interstitial was clicked")
    }

}

