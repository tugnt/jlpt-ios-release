//
//  LoginViewController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/23.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.layer.cornerRadius = 3.0
            emailTextField.clipsToBounds = true
        }
    }

    @IBOutlet weak var passTextField: UITextField!

    @IBOutlet weak var facebookBtn: UIButton! {
        didSet {
            facebookBtn.setBackgroundImage(Asset.facebook.image, for: .normal)
        }
    }

    @IBOutlet weak var googleBtn: UIButton! {
        didSet {
            googleBtn.setBackgroundImage(Asset.google.image, for: .normal)
        }
    }

    @IBOutlet weak var loginBtn: UIButton! {
        didSet {
            loginBtn.layer.cornerRadius = 3.0
            loginBtn.clipsToBounds = true
        }
    }

    @IBOutlet weak var notYetAccountBtn: UIButton!
    @IBOutlet weak var skipLogginBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        notYetAccountBtn.addTarget(self, action: #selector(moveRegisterScreen), for: .touchUpInside)
        skipLogginBtn.addTarget(self, action: #selector(skipLoggin), for: .touchUpInside)
    }

    @objc func moveRegisterScreen() {
        self.navigationController?.pushViewController(StoryboardScene.Register.registerViewController.instantiate(), animated: true)
    }

    @objc func skipLoggin() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.window?.rootViewController = TabbarController()
    }
}
