//
//  StartAppViewController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/28.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//
import UIKit
import Lottie
import SnapKit
import Realm
import RealmSwift

class StartAppViewController: UIViewController {
    @IBOutlet weak var imageBackground: UIImageView!
    private var isSigned: Bool = false {
        didSet {
            startButton.isHidden = isSigned
        }
    }
    private let startButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorName.navBackground.color
        self.setUpWaveView()
        self.setUpStartButton()
    }
    
    private func setUpWaveView() {
        let wave = WaveView()
        view.addSubview(wave)
        wave.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.height.equalTo(200)
            make.top.equalToSuperview().offset(150)
        }
    }
    
    private func setUpStartButton() {
        startButton.setTitle("Bắt đầu", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.200000003)
        startButton.titleEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        startButton.layer.borderWidth = 1
        startButton.layer.cornerRadius = 3
        startButton.layer.borderColor = UIColor(white: 1, alpha: 0.3).cgColor
        view.addSubview(startButton)
        
        let margin = 8
        let maxWidth = 315
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(view).offset(-30)
            make.centerX.equalTo(view)
            make.width.lessThanOrEqualTo(maxWidth)
            make.width.lessThanOrEqualTo(view).inset(margin)
            make.width.equalTo(view).priority(500)
            make.height.equalTo(46)
        }
        startButton.addTarget(self, action: #selector(startApplication), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let realm = try? Realm()
        let accounts = realm?.objects(Account.self)
        if (accounts?.count != 0 && accounts != nil) || Setting.firstRunApp {
            isSigned = true
            self.moveMainScreen()
        }
        if !Setting.firstRunApp {
            Setting.coins = 5
        }
    }
    
    private func moveMainScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            appDelegate.window?.rootViewController = TabbarViewController()
        })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc private func startApplication() {
        let vc = StoryboardScene.LoginViewController.loginViewController.instantiate()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        Setting.firstRunApp = true
        appDelegate.window?.rootViewController = vc
    }
}
