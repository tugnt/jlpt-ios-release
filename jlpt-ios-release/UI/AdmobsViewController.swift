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
    private let rewardVideoUnitId = "ca-app-pub-3940256099942544/1712485313"
    private let banderUnitId = ""
    private let insterstitialUnitId = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rewardBasedVideo = GADRewardBasedVideoAd.sharedInstance()
        rewardBasedVideo?.delegate = self
    }

    func loadAdsVideo() {
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        if !adRequestInProgress && rewardBasedVideo?.isReady == false {
            rewardBasedVideo?.load(GADRequest(), withAdUnitID: rewardVideoUnitId)
            adRequestInProgress = true
        }
    }
    
    func presentRewardAdVideo() {
        print("First load is true")
        if rewardBasedVideo?.isReady == true {
            rewardBasedVideo?.present(fromRootViewController: self)
        } else {
            // Todo: Show alert or toast here
            self.showAlertDialog(title: "Thông báo", content: "Error: Chưa load đc ads", titleButton: "OK", cancelAction: {
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
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
    }
}
