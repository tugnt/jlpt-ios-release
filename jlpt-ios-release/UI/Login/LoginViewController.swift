//
//  LoginViewController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/23.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import SnapKit
import GoogleSignIn
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var notYetAccountBtn: UIButton!
    @IBOutlet weak var skipLogginBtn: UIButton!
    private var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        notYetAccountBtn.addTarget(self, action: #selector(moveRegisterScreen), for: .touchUpInside)
        skipLogginBtn.addTarget(self, action: #selector(skipLoggin), for: .touchUpInside)
        googleBtn.addTarget(self, action: #selector(loginViaGoogle), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTextField.setUpLoginTextField()
        emailTextField.clipsToBounds = true
        passTextField.setUpLoginTextField()
        facebookBtn.setBackgroundImage(Asset.facebook.image, for: .normal)
        googleBtn.setBackgroundImage(Asset.google.image, for: .normal)
        loginBtn.layer.cornerRadius = 3.0
        loginBtn.clipsToBounds = true
    }

    @objc private func loginViaGoogle() {
        GIDSignIn.sharedInstance().signIn()
    }

    @objc private func moveRegisterScreen() {
        let vc: RegisterViewController = StoryboardScene.Register.registerViewController.instantiate()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }

    @objc private func skipLoggin() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.window?.rootViewController = TabbarController()
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        startAnimationLoading()
        /// Login Success -> Save user data and move to main screen
        if user != nil {
            if let auth = user.authentication {
                let credential = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
                Auth.auth().signIn(with: credential, completion: { (user, _) in
                    /** Save data in local
                     Save user data to Firebas
                     Move to main screen
                     TODO: Kiểm tra nếu đã tồn tại ở db thì sẽ ko ghi lại người dùng này nữa, tránh trùng lặp
                     */
                    self.ref = Database.database().reference()
                    if let userInfo = user {
                        guard let photoUrl = userInfo.photoURL?.absoluteString else { return }
                        self.ref.child("users").child(userInfo.uid).setValue(["email": userInfo.email, "name": userInfo.displayName, "photoUrl": photoUrl], withCompletionBlock: { (err, _) in
                            if err != nil {
                                self.showLoginAlert(title: "Thông báo", description: "Đăng nhập Google thất bại. \n Vui lòng thử lại sau.")
                            }
                            self.stopAnimationLoading()
                            /// Todo: Save user data to local
                            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                            appDelegate.window?.rootViewController = TabbarController()
                        })
                    } else {
                        self.stopAnimationLoading()
                        self.showLoginAlert(title: "Thông báo", description: "Đăng nhập Google thất bại. \n Vui lòng thử lại sau.")
                    }
                })
            }
        } else {
            if let err = error as NSError? {
                guard let codeError = GIDSignInErrorCode(rawValue: err.code) else { return }
                switch codeError {
                case .canceled:
                    break
                case .hasNoAuthInKeychain, .keychain, .noSignInHandlersInstalled, .unknown:
                    showLoginAlert(title: "Thông báo", description: "Đăng nhập Google thất bại. \n Vui lòng thử lại sau.")
                }
            }
            stopAnimationLoading()
        }
    }

    private func showLoginAlert(title: String, description: String) {
        let alertModal = TDModalStatusView(frame: view.bounds)
        alertModal.setTitleLabel(title: title)
        alertModal.setSubTitleLabel(subTitle: description)
        alertModal.setStatusImage(image: Asset.notificationIcon.image)
        view.addSubview(alertModal)
    }
}
