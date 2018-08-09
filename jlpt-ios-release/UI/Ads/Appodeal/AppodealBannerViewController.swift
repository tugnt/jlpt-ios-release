//
//  AppodealBannerViewController.swift
//  jlpt-ios-release
//
//  Created by t_nguyen on 2018/08/07.
//  Copyright © 2018年 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import Appodeal

class AppodealBannerViewController : UIViewController, AppodealBannerViewDelegate {
    var bannerView: AppodealBannerView!
    
    override func viewDidLoad () {
        super.viewDidLoad()
        bannerView = AppodealBannerView.init(size: kAppodealUnitSize_320x50, rootViewController: self)
        self.view.addSubview(bannerView)
        bannerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(60)
        }
        bannerView.delegate = self
        bannerView.rootViewController = self
        bannerView.loadAd()
    }
    
    // optional: implement any of AppodealBannerViewDelegate methods
    func bannerViewDidLoadAd(_ bannerView: APDBannerView){
        NSLog("Banner view was loaded")
    }
    
    func bannerViewDidRefresh(_ bannerView: APDBannerView!){
        NSLog("banner view was refreshed")
    }
    
    func bannerView(_ bannerView: APDBannerView, didFailToLoadAdWithError error: Error){
        NSLog("banner view failed to load")
    }
    
    func bannerViewDidInteract(_ bannerView: APDBannerView){
        NSLog("banner view was clicked")
    }
    
    func bannerViewDidShow(_ bannerView: APDBannerView) {
        print("Banner đã được hiển thị")
    }
}
