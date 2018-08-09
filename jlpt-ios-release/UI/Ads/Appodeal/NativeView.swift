//
//  NativeView.swift
//  jlpt-ios-release
//
//  Created by t_nguyen on 2018/08/23.
//  Copyright © 2018年 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import Appodeal

class NativeView: UIView {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var callToAction: UILabel!
    @IBOutlet weak var descr: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var mediaContainer: UIView!
    @IBOutlet weak var choiseView: UIView!
    
    
    lazy var adChoise: UIView = {
        let view = UIView()
        return view
    }()
    
    override func draw(_ rect: CGRect) {
        self.icon.layer.cornerRadius = 10.0
        self.icon.layer.masksToBounds = true
        
        self.callToAction.layer.cornerRadius = 10.0
        self.callToAction.layer.masksToBounds = true
    }
}

extension NativeView : APDNativeAdView {
    
    func titleLabel() -> UILabel {
        return title
    }
    
    func callToActionLabel() -> UILabel {
        return callToAction
    }
    
    func descriptionLabel() -> UILabel {
        return descr
    }
    
    func iconView() -> UIImageView {
        return icon
    }
    
    func mediaContainerView() -> UIView {
        return mediaContainer
    }
    
    func adChoicesView() -> UIView {
        return choiseView
    }
    
    static func nib() -> UINib {
        return UINib.init(nibName: "NativeView", bundle: Bundle.main)
    }
}
