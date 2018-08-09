//
//  ProcessViewController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/16.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

class ProcessViewController: UIViewController {
    @IBOutlet weak var autoAppodealSwitch: UISwitch!
    @IBOutlet weak var autoFacebookInterstitialSwitch: UISwitch!
    @IBOutlet weak var autoShowAdsSwitch: UISwitch!
    @IBOutlet weak var autoNendBanner: UISwitch!
    
    @IBOutlet var autoAdSwitches: [UISwitch]!
    
    @IBOutlet weak var reportButton: UIButton! {
        didSet {
            reportButton.clipsToBounds = true
            reportButton.layer.cornerRadius = 5
            reportButton.layer.borderColor = UIColor.blue.cgColor
            reportButton.layer.borderWidth = 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Báo cáo"
    }
    
    private func disableOtherSwitch(autoSwitch: UISwitch) {
        autoAdSwitches.forEach {
            if autoSwitch.isOn {
                $0.isOn = $0 == autoSwitch
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.autoAppodealSwitch.isOn = Setting.isAutoAppodeal
        self.autoFacebookInterstitialSwitch.isOn = Setting.isAutoFacebookInterstitial
        self.autoShowAdsSwitch.isOn = Setting.isAutoShowAds
        self.autoNendBanner.isOn = Setting.isNendAutoLoad
    }
    
    @IBAction func appodealDidSwitch(_ sender: Any) {
        disableOtherSwitch(autoSwitch: autoAppodealSwitch)
        Setting.isAutoAppodeal = autoAppodealSwitch.isOn
    }
    
    @IBAction func facebookDidSwitch(_ sender: Any) {
        disableOtherSwitch(autoSwitch: autoFacebookInterstitialSwitch)
        Setting.isAutoFacebookInterstitial = autoFacebookInterstitialSwitch.isOn
    }
    
    @IBAction func autoShowAdsDidSwitch(_ sender: Any) {
        disableOtherSwitch(autoSwitch: autoShowAdsSwitch)
        Setting.isAutoShowAds = autoShowAdsSwitch.isOn
    }
    
    @IBAction func nendAutoDidSwitched(_ sender: Any) {
        disableOtherSwitch(autoSwitch: autoNendBanner)
        Setting.isNendAutoLoad = autoNendBanner.isOn
    }
}
