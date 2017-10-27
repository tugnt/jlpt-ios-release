//
//  StartAppController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/28.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import Lottie
import SnapKit

class StartAppController: UIViewController {
    @IBOutlet weak var imageBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorName.navBackground.color
        // - Set up wave view
        let wave = WaveView()
        view.addSubview(wave)
        wave.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.height.equalTo(200)
            make.top.equalToSuperview().offset(150)
        }
        
        /// Setup start button
        let button = UIButton()
        button.setTitle("Bắt đầu", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(white: 1, alpha: 0.2)
        button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        button.layer.borderColor = UIColor(white: 1, alpha: 0.3).cgColor
        view.addSubview(button)
        
        let margin = 8
        let maxWidth = 315
        button.snp.makeConstraints { make in
            make.bottom.equalTo(view).offset(-30)
            make.centerX.equalTo(view)
            make.width.lessThanOrEqualTo(maxWidth)
            make.width.lessThanOrEqualTo(view).inset(margin)
            make.width.equalTo(view).priority(500)
            make.height.equalTo(50)
        }
        button.addTarget(self, action: #selector(startApplication), for: .touchUpInside)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func startApplication() {
        //let vc = TabbarController()
        let vc = StoryboardScene.Login.loginViewController.instantiate()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.window?.rootViewController = vc
    }
}
