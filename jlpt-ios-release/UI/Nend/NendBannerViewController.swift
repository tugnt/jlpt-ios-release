//
//  NendBannerViewController.swift
//  jlpt-ios-release
//
//  Created by t_nguyen on 2018/08/07.
//  Copyright © 2018年 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import NendAd

class NendBannerViewController: UIViewController, NADViewDelegate {
    //private var nadView: NADView!
    
    @IBOutlet weak var nadView: NADView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Nend"
        nadView.setNendID("3320ecbecc5d913eceb0befe67375b71bbb48c4d", spotID: "886891")
        nadView.delegate = self
        nadView.load()
        print("Chay vao day khong")
    }
    
    func nadViewDidFinishLoad(_ adView: NADView!) {
        print("delegate nadViewDidFinishLoad:")
    }
    
    func nadViewDidClickAd(_ adView: NADView!) {
        print("delegate nadViewDidClickAd")
    }
    
    func nadViewDidClickInformation(_ adView: NADView!) {
        print("delegate nadViewDidClickInformation")
    }
    
    func nadViewDidReceiveAd(_ adView: NADView!) {
        print("delegate nadViewDidReceiveAd")
    }
    
    func nadViewDidFail(toReceiveAd adView: NADView!) {
        // separate by error
        let error = adView.error as NSError
        
        switch (error.code) {
        case NADViewErrorCode.NADVIEW_AD_SIZE_TOO_LARGE.hashValue:
            // The ad size is larger than the banner size
            break
        case NADViewErrorCode.NADVIEW_INVALID_RESPONSE_TYPE.hashValue:
            // Invalid banner type
            break
        case NADViewErrorCode.NADVIEW_FAILED_AD_REQUEST.hashValue:
            // Failed ad request
            break
        case NADViewErrorCode.NADVIEW_FAILED_AD_DOWNLOAD.hashValue:
            // Failed ad download
            break
        case NADViewErrorCode.NADVIEW_AD_SIZE_DIFFERENCES.hashValue:
            // difference in ad sizes
            break
        default:
            break
        }
    }
}
