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
        jlptAnimation()
    }
    
    func jlptAnimation() {
        // - List array url animation json. This include 4 words J, L, P, T
        let urlArray: [String] = ["https://raw.githubusercontent.com/airbnb/lottie-ios/master/Example/Tests/TypeFace/J.json",
                                  "https://raw.githubusercontent.com/airbnb/lottie-ios/master/Example/Tests/TypeFace/L.json",
                                  "https://raw.githubusercontent.com/airbnb/lottie-ios/master/Example/Tests/TypeFace/P.json",
                                  "https://raw.githubusercontent.com/airbnb/lottie-ios/master/Example/Tests/TypeFace/T.json"]
        var animations: [LOTAnimationView] = []
        
        for url in urlArray {
            let animation = LOTAnimationView(contentsOf: URL(string: url)!)
            animations.append(animation)
            view.addSubview(animation)
        }
        
        let widthScreen = view.bounds.width
        let withText: CGFloat = 60
        let padding = Int((widthScreen - ( withText * 4 )) / 2 )
        for (index, aniView) in animations.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false
            view.addConstraintsWithFormat("H:|-\(index * Int(withText) + padding)-[v0(\(withText))]-|", views: aniView)
            view.addConstraintsWithFormat("V:|-300-[v0(60)]|", views: aniView)
            aniView.play()
        }
    }
    
    @objc func startApp() {
        let vc = StoryboardScene.Introduction.introductionController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
