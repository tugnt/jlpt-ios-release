//
//  SmaatoInterstitialViewController.swift
//  jlpt-ios-release
//
//  Created by t_nguyen on 2018/08/28.
//  Copyright © 2018年 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import iSoma

class SmaatoInterstitialViewController: UIViewController {
    private var interstitialView: SOMAInterstitialAdView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        interstitialView = SOMAInterstitialAdView(frame: self.view.frame)
        interstitialView?.delegate = self
        interstitialView?.load()
    }
}

extension SmaatoInterstitialViewController: SOMAAdViewDelegate {
    func somaAdViewDidLoadAd(_ adview: SOMAAdView!) {
        interstitialView?.show(self)
    }

    func somaAdViewDidClick(_ adview: SOMAAdView!) {
        
    }

    func somaAdViewWillHide(_ adview: SOMAAdView!) {
    
    }

    func somaAdViewDidEnterFullscreen(_ adview: SOMAAdView!) {
        
    }
}

