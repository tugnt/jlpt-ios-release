//
//  StartAppController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/28.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import Lottie

class StartAppController: UIViewController {
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var startButton: UIButton! {
        didSet {
            startButton.setBackgroundImage(UIImage(named: "start_button"), for: .normal)
            startButton.addTarget(self, action: #selector(startApp), for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // - Set up image background
        let imageBackground = UIImage(named: "background")
        self.imageBackground.image = imageBackground
        // - Load JLPT animation
    }
    
    
    @objc func startApp() {
        let vc = StoryboardScene.Introduction.introductionController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
