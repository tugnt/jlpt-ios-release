//
//  AdmobsViewController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2018/05/07.
//  Copyright © 2018 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AdmobsViewController: UIViewController {
    /// Bander ads -----------------------
    
    /// Instial ads ------------------------
    
    /// Reward Base Video -------------------------
    private var adRequestInProgress = false
    private var rewardBasedVideo: GADRewardBasedVideoAd?
    private let rewardVideoUnitId = "ca-app-pub-8167183150215759/3144550312"
    private let banderUnitId = ""
    private let insterstitialUnitId = ""
    var checkCallBack: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rewardBasedVideo = GADRewardBasedVideoAd.sharedInstance()
        rewardBasedVideo?.delegate = self
    }
    
    func loadAdsVideo() {
        let request = GADRequest()
        if !adRequestInProgress && rewardBasedVideo?.isReady == false {
            rewardBasedVideo?.load(request, withAdUnitID: rewardVideoUnitId)
            adRequestInProgress = true
        }
    }
    
    func presentRewardAdVideo() {
        if rewardBasedVideo?.isReady == true {
            rewardBasedVideo?.present(fromRootViewController: self)
        } else {
            // Todo: Show alert or toast here
            self.showAlertDialog(title: "Thông báo", content: "Có lỗi xảy ra. Bạn vui lòng thử lại sau.", titleButton: "OK", cancelAction: {
                print("Show nothing")
            })
        }
    }
}

extension AdmobsViewController: GADRewardBasedVideoAdDelegate {
    // MARK: GADRewardBasedVideoAdDelegate implementation
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didFailToLoadWithError error: Error) {
        adRequestInProgress = false
        print("Reward based video ad failed to load: \(error.localizedDescription)")
    }
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        adRequestInProgress = false
        print("Reward based video ad is received.")
    }
    
    func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Opened reward based video ad.")
    }
    
    func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad started playing.")
    }
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad is closed.")
        loadAdsVideo()
    }
    
    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad will leave application.")
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward) {
        self.earnCoins()
        self.checkCallBack?()
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
    }
}
