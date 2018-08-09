//
//  AppodealNativeAdViewController.swift
//  jlpt-ios-release
//
//  Created by t_nguyen on 2018/08/20.
//  Copyright © 2018年 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import Appodeal


class AppodealNativeAdViewController: UIViewController {
    @IBOutlet weak var nativeAdContainer: UIView!
    
    let nativeAdStack : NSMapTable <NSIndexPath, APDNativeAd> = NSMapTable(keyOptions: .strongMemory, valueOptions: .strongMemory)
    
    lazy var nativeAdQueue: APDNativeAdQueue = {
        return APDNativeAdQueue(sdk: nil, settings: self.nativeAdSettings, delegate: self, autocache: true)
    }()
    
    var nativeAdSettings: APDNativeAdSettings! {
        get {
            let instance = APDNativeAdSettings()
            instance.adViewClass = NativeView.self
            return instance;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nativeAdQueue.loadAd()
        DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
            self.navigationController?.popViewController(animated: true)
        })
    }
    
    func presentNative() {
        var nativeAd: APDNativeAd?
        print("Number ads")
        print(nativeAdQueue.getNativeAds(ofCount: 1).count)
        nativeAd = nativeAdQueue.getNativeAds(ofCount: 1).first
        if let navAd = nativeAd, let nativeView = navAd.getViewFor(self) {
            self.nativeAdContainer.addSubview(nativeView)
            nativeView.snp.makeConstraints { make in
                make.height.width.centerX.centerY.equalToSuperview()
            }
        }
    }
}

extension AppodealNativeAdViewController: APDNativeAdQueueDelegate {
    /// Method called when loader receives native ad.
    ///
    /// - Parameters:
    ///   - adQueue: ad queue object
    ///   - count: count of available native ad
    func adQueueAdIsAvailable(_ adQueue: APDNativeAdQueue, ofCount count: UInt) {
        self.presentNative()
    }
    
    /// Method called when loader fails to receive native ad.
    ///
    /// - Parameters:
    ///   - adQueue: ad queue object
    ///   - error: Error occurred
    func adQueue(_ adQueue: APDNativeAdQueue, failedWithError error: Error) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            print("Load failed")
            self.nativeAdQueue.loadAd()
        })
    }
    
    func nativeAdLoader(_ loader: APDNativeAdQueue, didLoad nativeAds: [APDNativeAd]){
        print("Load new ads")
//        self.nativeAds = adQueue.getNativeAds(ofCount: 5)
//        NSLog("native ad was loaded")
//        print(self.nativeAds)
    }
    
    func nativeAdLoader(_ loader: APDNativeAdQueue, didFailToLoadWithError error: Error){
        NSLog("native ad failed to load")
    }
    
    func nativeAdWillLogImpression(_ nativeAd: APDNativeAd!) {
        NSLog("native ad was shown")
    }
    
    func nativeAdWillLogUserInteraction(_ nativeAd: APDNativeAd!) {
        NSLog("native ad was clicked")
    }
}
