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
    private var nadView1: NADView!
    private var nadView2: NADView!
    private var nadView3: NADView!
    private var nadView4: NADView!
    private var nadView5: NADView!
    private var view1: NADView!
    private var view2: NADView!
    private var view3: NADView!
    private var view4: NADView!
    private var view5: NADView!
    private var view6: NADView!
    private var view7: NADView!
    
    private lazy var coutingLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private var numberLoaded: Int = 0
    @IBOutlet var nendBannerViews: [NADView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Nend"
        nadView = NADView()
        nadView.setNendID("1bc76ffe7caa22967c2e0e2b0e7d464eda139b4c", spotID: "899712")
        nadView.delegate = self
        self.view.addSubview(nadView)
        nadView.snp.makeConstraints { make in
            make.width.equalTo(320)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        //
        nadView1 = NADView()
        nadView1.setNendID("1bc76ffe7caa22967c2e0e2b0e7d464eda139b4c", spotID: "899712")
        nadView1.delegate = self
        self.view.addSubview(nadView1)
        nadView1.snp.makeConstraints { make in
            make.width.equalTo(320)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(nadView.snp.top)
        }
        
        nadView2 = NADView()
        nadView2.setNendID("1bc76ffe7caa22967c2e0e2b0e7d464eda139b4c", spotID: "899712")
        nadView2.delegate = self
        self.view.addSubview(nadView2)
        nadView2.snp.makeConstraints { make in
            make.width.equalTo(320)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(nadView1.snp.top)
        }
        
        nadView3 = NADView()
        nadView3.setNendID("1bc76ffe7caa22967c2e0e2b0e7d464eda139b4c", spotID: "899712")
        nadView3.delegate = self
        self.view.addSubview(nadView3)
        nadView3.snp.makeConstraints { make in
            make.width.equalTo(320)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(nadView2.snp.top)
        }
        
        nadView4 = NADView()
        nadView4.setNendID("1bc76ffe7caa22967c2e0e2b0e7d464eda139b4c", spotID: "899712")
        nadView4.delegate = self
        self.view.addSubview(nadView4)
        nadView4.snp.makeConstraints { make in
            make.width.equalTo(320)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(nadView3.snp.top)
        }
        
        nadView5 = NADView()
        nadView5.setNendID("1bc76ffe7caa22967c2e0e2b0e7d464eda139b4c", spotID: "899712")
        nadView5.delegate = self
        self.view.addSubview(nadView5)
        nadView5.snp.makeConstraints { make in
            make.width.equalTo(320)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(nadView4.snp.top)
        }
        
        view1 = NADView()
        view1.setNendID("1bc76ffe7caa22967c2e0e2b0e7d464eda139b4c", spotID: "899712")
        view1.delegate = self
        self.view.addSubview(view1)
        view1.snp.makeConstraints { make in
            make.width.equalTo(320)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(nadView.snp.bottom)
        }
        
        view2 = NADView()
        view2.setNendID("1bc76ffe7caa22967c2e0e2b0e7d464eda139b4c", spotID: "899712")
        view2.delegate = self
        self.view.addSubview(view2)
        view2.snp.makeConstraints { make in
            make.width.equalTo(320)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(view1.snp.bottom)
        }
        
        view3 = NADView()
        view3.setNendID("1bc76ffe7caa22967c2e0e2b0e7d464eda139b4c", spotID: "899712")
        view3.delegate = self
        self.view.addSubview(view3)
        view3.snp.makeConstraints { make in
            make.width.equalTo(320)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(view2.snp.bottom)
        }
        
        view4 = NADView()
        view4.setNendID("1bc76ffe7caa22967c2e0e2b0e7d464eda139b4c", spotID: "899712")
        view4.delegate = self
        self.view.addSubview(view4)
        view4.snp.makeConstraints { make in
            make.width.equalTo(320)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(view3.snp.bottom)
        }
        
        view5 = NADView()
        view5.setNendID("1bc76ffe7caa22967c2e0e2b0e7d464eda139b4c", spotID: "899712")
        view5.delegate = self
        self.view.addSubview(view5)
        view5.snp.makeConstraints { make in
            make.width.equalTo(320)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(view4.snp.bottom)
        }
        
        view6 = NADView()
        view6.setNendID("1bc76ffe7caa22967c2e0e2b0e7d464eda139b4c", spotID: "899712")
        view6.delegate = self
        self.view.addSubview(view6)
        view6.snp.makeConstraints { make in
            make.width.equalTo(320)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(view5.snp.bottom)
        }
        
        self.view1.load()
        self.view2.load()
        self.view3.load()
        self.view4.load()
        self.view5.load()
        self.view6.load()
        self.nadView4.load()
        self.nadView5.load()
        self.nadView3.load()
        self.nadView2.load()
        self.nadView1.load()
        self.nadView.load()
        if Setting.isNendAutoLoad {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
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
            make.top.equalToSuperview()
        }
    }
}

extension NendBannerViewController: NADViewDelegate {
    func nadViewDidFinishLoad(_ adView: NADView!) {
        adView.load()
        print("delegate nadViewDidFinishLoad:")
    }
    
    
    func nadViewDidClickAd(_ adView: NADView!) {
        print("delegate nadViewDidClickAd")
    }
    
    func nadViewDidReceiveAd(_ adView: NADView!) {
        print("delegate nadViewDidReceiveAd")
        Setting.numberNendBannerInpression = Setting.numberNendBannerInpression + 1
        coutingLabel.text = "\(Setting.numberNendBannerInpression) ad impression"
        adView.load()
    }
    
    func nadViewDidFail(toReceiveAd adView: NADView!) {
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
