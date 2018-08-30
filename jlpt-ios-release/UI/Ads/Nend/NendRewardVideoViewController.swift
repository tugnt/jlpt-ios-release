//
//  NendRewardVideoViewController.swift
//  jlpt-ios-release
//
//  Created by t_nguyen on 2018/08/30.
//  Copyright © 2018年 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import NendAd

class NendRewardVideoViewController: UIViewController {
    private let rewardedVideo = NADRewardedVideo(spotId: "904318", apiKey: "141bb0f37be0796323eb7a043d057a7b22482c86")
    private var isComplete: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rewardedVideo.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "\(Setting.numberRewardVideo)"
        self.rewardedVideo.loadAd()
    }
}

extension NendRewardVideoViewController: NADRewardedVideoDelegate {
    func nadRewardVideoAd(_ nadRewardedVideoAd: NADRewardedVideo!, didReward reward: NADReward!) {
        print("Rewarded. Currency name: " + reward.name! + ", Currency amount: \(reward.amount)")
        Setting.numberRewardVideo = Setting.numberRewardVideo + 1
    }
    
    func nadRewardVideoAdDidReceiveAd(_ nadRewardedVideoAd: NADRewardedVideo!) {
        if self.rewardedVideo.isReady {
            self.rewardedVideo.showAd(from: self)
            DispatchQueue.main.asyncAfter(deadline: .now() + 30, execute: {
                if !self.isComplete {
                    self.dismiss(animated: true, completion: {
                        self.navigationController?.popViewController(animated: false)
                    })
                }
            })
        }
        print("Rewarded Video Did Receive.")
    }
    
    func nadRewardVideoAd(_ nadRewardedVideoAd: NADRewardedVideo!, didFailToLoadWithError error: Error!) {
        self.navigationController?.popViewController(animated: false)
        print("Rewarded Video Did Fail to Receive. error: \(error)")
    }
    
    func nadRewardVideoAdDidOpen(_ nadRewardedVideoAd: NADRewardedVideo!) {
        print("Rewarded Video Did Open.")
    }
    
    func nadRewardVideoAdDidStartPlaying(_ nadRewardedVideoAd: NADRewardedVideo!) {
        print("Rewarded Video Did Start Playing.")
    }
    
    func nadRewardVideoAdDidStopPlaying(_ nadRewardedVideoAd: NADRewardedVideo!) {
        print("Rewarded Video Did Stop Playing.")
    }
    
    func nadRewardVideoAdDidCompletePlaying(_ nadRewardedVideoAd: NADRewardedVideo!) {
        print("Rewarded Video Did Complete Playing.")
        self.dismiss(animated: true, completion: {
            self.navigationController?.popViewController(animated: false)
        })
    }
    
    func nadRewardVideoAdDidClose(_ nadRewardedVideoAd: NADRewardedVideo!) {
        print("Rewarded Video Did Close.")
    }
    
    func nadRewardVideoAdDidClickAd(_ nadRewardedVideoAd: NADRewardedVideo!) {
        print("Rewarded Video Did Click Ad.")
    }
    
    
    func nadRewardVideoAdDidClickInformation(_ nadRewardedVideoAd: NADRewardedVideo!) {
        print("Rewarded Video Did Click Information.")
    }
    
}
