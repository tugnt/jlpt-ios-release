//
//  AppodealRewardVideoViewController.swift
//  jlpt-ios-release
//
//  Created by t_nguyen on 2018/08/20.
//  Copyright © 2018年 Nguyen Trong Tung. All rights reserved.
//

import Foundation
import Appodeal

class AppodealRewardVideoViewController: UIViewController, AppodealRewardedVideoDelegate {
    private var adsIsFinished: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Appodeal"
        Appodeal.setRewardedVideoDelegate(self)
    }
    
    @IBAction func facebookInterstitialControler(_ sender: Any) {
        let vc = StoryboardScene.FacebookInterstitialViewController.facebookInterstitialViewController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func forceDismissAdsWhenError() {
        self.adsIsFinished = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 30, execute: {
            if !self.adsIsFinished {
                self.forceDismissAdsWhenError()
            }
        })
    }
    
    func rewardedVideoDidLoadAd(){
        Appodeal.showAd(.rewardedVideo, rootViewController: self)
        self.adsIsFinished = false
        self.forceDismissAdsWhenError()
    }
    
    func rewardedVideoDidFailToLoadAd(){
        NSLog("video ad failed to load")
        self.forceDismissAdsWhenError()
    }
    
    func rewardedVideoDidPresent(){
        NSLog("video ad was presented");
    }
    
    func rewardedVideoWillDismiss(){
        NSLog("video ad was closed");
    }
    
    func rewardedVideoDidFinish(_ rewardAmount: UInt, name rewardName: String?){
        self.dismiss(animated: true, completion: nil)
        self.adsIsFinished = true
        NSLog("video ad was fully watched");
    }
}
