//
//  RegisterViewController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/24.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rePasswordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var registerFbButton: UIButton!
    @IBOutlet weak var registerGoogleButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addDismissButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTextField.setUpLoginTextField()
        passwordTextField.setUpLoginTextField()
        rePasswordTextField.setUpLoginTextField()
        userNameTextField.setUpLoginTextField()
    }

    func addDismissButton() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        let dismissButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        dismissButton.setImage(Asset.dismissBtn.image, for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissRegister), for: .touchUpInside)
        view.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(30)
            make.width.height.equalTo(30)
        }
    }

    @objc func dismissRegister() {
        self.dismiss(animated: true, completion: nil)
    }
}
