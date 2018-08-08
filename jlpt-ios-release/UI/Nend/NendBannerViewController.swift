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
    private var nadView: NADView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var magnification = self.view.frame.size.width / 320
        magnification = 50 * magnification
        nadView = NADView(frame: CGRect(x: 0, y: self.view.frame.size.height - magnification ,
                                        width: self.view.frame.size.width,
                                        height: magnification), isAdjustAdSize: true)
        nadView.setNendID("3320ecbecc5d913eceb0befe67375b71bbb48c4d",spotID: "886891")
        nadView.delegate = self
        nadView.load()
        self.view.addSubview(nadView)
        adTimer()
    }
    
    var timer = Timer()
    func adTimer(){
        self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(adShow), userInfo: nil, repeats: false)
    }
    
    @objc func adShow() {
        let showResult = NADInterstitial.sharedInstance().showAd(from: self)
        switch(showResult){
        case .AD_SHOW_SUCCESS:
            print("Quang cao thanh cong")
            break
        case .AD_SHOW_ALREADY:
            print("Da duoc hien thi")
            break
        case .AD_FREQUENCY_NOT_REACHABLE:
            print("Chưa đạt đến số lượng tần suất quảng cáo.")
            break
        case .AD_LOAD_INCOMPLETE:
            print("Yêu cầu xổ số chưa được thực hiện hoặc đang chạy.")
            break
        case .AD_REQUEST_INCOMPLETE:
            print("Tôi đã thất bại trong yêu cầu.")
            break
        case .AD_DOWNLOAD_INCOMPLETE:
            print("Tải xuống quảng cáo chưa được hoàn thành.")
            break
        case .AD_CANNOT_DISPLAY:
            print("Quảng cáo không thể được hiển thị trên ViewController đã chỉ định。")
            break
        }
    }
    
    
}
