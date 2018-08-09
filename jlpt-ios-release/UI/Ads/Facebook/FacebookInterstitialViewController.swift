//
//  FacebookInterstitialViewController.swift
//  jlpt-ios-release
//
//  Created by t_nguyen on 2018/08/14.
//  Copyright © 2018年 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import FBAudienceNetwork

struct InterstitialPlacementID {
    let namePlacementID: String
    let placementID: String
}

class FacebookInterstitialViewController: UIViewController, FBInterstitialAdDelegate {
    private var interstitialAd: FBInterstitialAd?
    var isLoaded: Bool = false
    var numberForceReload = 0
    var curentIndexOfPlacementID: Int = 0
    private let placementIDs: [String] = ["2066665896941070_2067607373513589", // hight_CPM
                                          "2066665896941070_2067606986846961", // lowest_eCPM
                                          "2066665896941070_2067606683513658"] // any_price_eCPM
    
    @IBOutlet weak var reloadButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Facebook Interstitial"
        reloadButton.addTarget(self, action: #selector(forceReload), for: .touchUpInside)
        interstitialAd = FBInterstitialAd(placementID: placementIDs[0])
        interstitialAd?.delegate = self
        interstitialAd?.load()
    }
    
    @objc private func forceReload() {
        interstitialAd?.load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isLoaded {
            self.interstitialAd?.show(fromRootViewController: self)
        }
    }
    
    func interstitialAdDidLoad(_ interstitialAd: FBInterstitialAd) {
        self.reloadButton.backgroundColor = .blue
        self.reloadButton.setTitleColor(.white, for: .normal)
        self.isLoaded = true
        if interstitialAd.isAdValid {
            interstitialAd.show(fromRootViewController: self)
            if Setting.isAutoShowAds {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                    self.isLoaded = true
                    self.dismiss(animated: true, completion: {
                        self.navigationController?.popViewController(animated: true)
                    })
                })
            }
        }
    }
    
    func interstitialAdDidClick(_ interstitialAd: FBInterstitialAd) {
        print("interstitialAdDidClick")
    }
    
    func interstitialAdDidClose(_ interstitialAd: FBInterstitialAd) {
        print("interstitialAdDidClose")
    }
    
    func interstitialAdWillClose(_ interstitialAd: FBInterstitialAd) {
        print("interstitialAdWillClose")
    }
    
    func interstitialAdWillLogImpression(_ interstitialAd: FBInterstitialAd) {
    }
    
    func interstitialAd(_ interstitialAd: FBInterstitialAd, didFailWithError error: Error) {
        print("Adload failed")
        self.reloadButton.backgroundColor = .red
        self.reloadButton.setTitleColor(.white, for: .normal)
    }
}
