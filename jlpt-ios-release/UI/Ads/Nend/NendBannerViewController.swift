//
//  NendBannerViewController.swift
//  jlpt-ios-release
//
//  Created by t_nguyen on 2018/08/27.
//  Copyright © 2018年 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import NendAd


class NendBannerViewController: UIViewController {
    private var nadView: NADView!
    private lazy var coutingLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private var numberLoaded: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Nend"
        nadView = NADView()
        self.view.addSubview(nadView)
        nadView.snp.makeConstraints { make in
            make.width.equalTo(320)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        nadView.setNendID("1bc76ffe7caa22967c2e0e2b0e7d464eda139b4c", spotID: "899712")
        nadView.delegate = self
        self.nadView.load()
        if Setting.isNendAutoLoad {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.navigationController?.popViewController(animated: true)
            })
        }
        addCoutingLabel()
    }
    
    private func addCoutingLabel() {
        view.addSubview(coutingLabel)
        coutingLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(20)
            make.top.equalTo(nadView.snp.bottom)
        }
    }
}

extension NendBannerViewController: NADViewDelegate {
    func nadViewDidFinishLoad(_ adView: NADView!) {
        print("delegate nadViewDidFinishLoad:")
    }
    
    
    func nadViewDidClickAd(_ adView: NADView!) {
        print("delegate nadViewDidClickAd")
    }
    
    func nadViewDidReceiveAd(_ adView: NADView!) {
        print("delegate nadViewDidReceiveAd")
        Setting.numberNendBannerInpression = Setting.numberNendBannerInpression + 1
        coutingLabel.text = "\(Setting.numberNendBannerInpression) ad impression"
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.nadView.load()
        })
    }
    
    func nadViewDidFail(toReceiveAd adView: NADView!) {
        // separate by error
        print("Dm deo load dc")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.nadView.load()
        })
        let error = adView.error as NSError
        switch (error.code) {
        case NADViewErrorCode.NADVIEW_AD_SIZE_TOO_LARGE.hashValue:
            print("The ad size is larger than the banner size")
        case NADViewErrorCode.NADVIEW_INVALID_RESPONSE_TYPE.hashValue:
            print("Invalid banner type")
        case NADViewErrorCode.NADVIEW_FAILED_AD_REQUEST.hashValue:
            print("Failed ad request")
        case NADViewErrorCode.NADVIEW_FAILED_AD_DOWNLOAD.hashValue:
            print("Failed ad download")
        case NADViewErrorCode.NADVIEW_AD_SIZE_DIFFERENCES.hashValue:
            print("difference in ad sizes")
        default:
            print("Deo biet loi gì")
            break
        }
    }
}
