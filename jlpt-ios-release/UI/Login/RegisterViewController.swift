//
//  RegisterViewController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/24.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import Firebase
import RxCocoa
import RxSwift

class RegisterViewController: HidenKeyboardViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rePasswordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var alertLabel: UILabel!
    private let disposeBag = DisposeBag()
    private var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        addDismissButton()
        validateRegister()
        registerButton.addTarget(self, action: #selector(registerEmail), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTextField.setUpLoginTextField()
        passwordTextField.setUpLoginTextField()
        rePasswordTextField.setUpLoginTextField()
        userNameTextField.setUpLoginTextField()
        alertLabel.isHidden = true
        alertLabel.text = "Thông tin chưa chính xác. \n Vui lòng kiểm tra lại."
        registerButton.clipsToBounds = true
        registerButton.layer.cornerRadius = 3.0
    }

    private func addDismissButton() {
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

    @objc private func dismissRegister() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc private func registerEmail() {
        startAnimationLoading()
        guard let email = emailTextField.text ,let password = passwordTextField.text else { return }
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                self.showRegisterAlert()
            } else {
                /// Save to Firebase
                guard let userInfo = user?.user else { return }
                self.ref = Database.database().reference()
                self.ref.child("users").child(userInfo.uid).setValue(["email": userInfo.email, "name": self.userNameTextField.text!], withCompletionBlock: { (err, _) in
                    if err != nil {
                        self.showRegisterAlert()
                    }
                    /// Move to home screen
                    self.stopAnimationLoading()
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                    appDelegate.window?.rootViewController = TabbarViewController()
                })
            }
        })
    }

    private func validateRegister() {
        let emailValid = emailTextField.rx.text.orEmpty.map({ _ in
            Validation.init(.emailRex).validateString(inputString: self.emailTextField.text!)
        }).share()
        let userNameValid = userNameTextField.rx.text.orEmpty.map({ _ in
            return !self.userNameTextField.text!.isEmpty
        }).share()
        let passwordValid = passwordTextField.rx.text.orEmpty.map({ _ in
            Validation.init(.emailPassRex).validateString(inputString: self.passwordTextField.text!)
        }).share()
        let rePasswordValid = rePasswordTextField.rx.text.orEmpty.map({ _ in
            return (self.passwordTextField.text!) == (self.rePasswordTextField.text!)
        }).share()
        let allValid = Observable.combineLatest(emailValid, userNameValid, passwordValid, rePasswordValid) { $0 && $1 && $2 && $3 }
        allValid.bind(to: registerButton.rx.isEnabled).disposed(by: disposeBag)
        allValid.bind(to: alertLabel.rx.isHidden).disposed(by: disposeBag)
    }

    private func showRegisterAlert() {
        let alertModal = TDModalStatusView(frame: view.bounds)
        alertModal.setStatusImage(image: Asset.notificationIcon.image)
        alertModal.setTitleLabel(title: "Thông báo")
        alertModal.setSubTitleLabel(subTitle: "Đăng ký thất bại. \n Vui lòng thử lại sau")
        view.addSubview(alertModal)
    }
}
