//
//  ChildIntroductionController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/24.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import Lottie

class ChildIntroductionController: UIViewController {
    var pageIndex: Int = 0
    
    @IBOutlet weak var loadingImage: UIImageView! {
        didSet {
            let image = UIImage(named: "loading_\(pageIndex)")
            loadingImage.image = image
        }
    }
    
    @IBOutlet weak var startButton: UIButton! {
        didSet {
            startButton.setBackgroundImage(UIImage(named: "start_button"), for: .normal)
            startButton.isHidden = pageIndex != 3
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.addTarget(self, action: #selector(startNow), for: .touchUpInside)
    }
    
    @objc func  startNow() {
        let vc = TabbarController()
        let _ = UINavigationController(rootViewController: vc)
        guard let window = UIApplication.shared.keyWindow else {
            assertionFailure("keyWindowがnil!!")
            return
        }
        window.rootViewController = vc
    }
}
