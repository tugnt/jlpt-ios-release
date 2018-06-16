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
import RealmSwift
import RxSwift
import RxCocoa
import FirebaseDatabase

class LoginViewController: HidenKeyboardViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var notYetAccountBtn: UIButton!
    @IBOutlet weak var skipLogginBtn: UIButton!
    @IBOutlet weak var alertLabel: UILabel!
    private var ref: DatabaseReference!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        addButtonAction()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        loginValidation()
    }
    
    private func setUpView() {
        emailTextField.setUpLoginTextField()
        emailTextField.clipsToBounds = true
        passTextField.setUpLoginTextField()
        googleBtn.setBackgroundImage(Asset.google.image, for: .normal)
        loginBtn.layer.cornerRadius = 3.0
        loginBtn.clipsToBounds = true
        alertLabel.text = "Thông tin chưa chính xác. \n Vui lòng kiểm tra lại."
        /// - Remove all user data from db
        let realm = try? Realm()
        do {
            try realm?.write {
                realm?.deleteAll()
            }
        } catch let error { print(error) }
    }
    
    private func addButtonAction() {
        notYetAccountBtn.addTarget(self, action: #selector(moveRegisterScreen), for: .touchUpInside)
        skipLogginBtn.addTarget(self, action: #selector(skipLoggin), for: .touchUpInside)
        googleBtn.addTarget(self, action: #selector(loginViaGoogle), for: .touchUpInside)
        loginBtn.addTarget(self, action: #selector(loginViaEmail), for: .touchUpInside)
    }
    
    private func loginValidation() {
        let emailValid = emailTextField.rx.text.orEmpty.map({ _ in
            Validation.init(.emailRex).validateString(inputString: self.emailTextField.text!)
        }).share()
        let passwordValid = passTextField.rx.text.orEmpty.map({ _ in
            Validation.init(.emailPassRex).validateString(inputString: self.passTextField.text!)
        }).share()
        let allValid = Observable.combineLatest(emailValid, passwordValid) { $0 && $1 }
        allValid.bind(to: loginBtn.rx.isEnabled).disposed(by: disposeBag)
        allValid.bind(to: alertLabel.rx.isHidden).disposed(by: disposeBag)
    }
    
    @objc private func loginViaEmail() {
        startAnimationLoading()
        let email = emailTextField.text ?? ""
        let password = passTextField.text ?? ""
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                self.stopAnimationLoading()
                self.showLoginAlert()
            }
            /// - Save user and move home screen
            if let userInfo = user?.user {
                let account = Account()
                account.email = userInfo.email
                account.userName = userInfo.displayName
                account.uid = userInfo.uid
                account.photoUrl = userInfo.photoURL?.absoluteString
                let realm = try? Realm()
                do {
                    try realm?.write {
                        realm?.add(account)
                        self.stopAnimationLoading()
                        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                        appDelegate.window?.rootViewController = TabbarViewController()
                    }
                } catch {
                    self.stopAnimationLoading()
                    self.showLoginAlert()
                }
            }
        })
    }
    
    @objc private func loginViaGoogle() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @objc private func moveRegisterScreen() {
        let vc: RegisterViewController = StoryboardScene.RegisterViewController.registerViewController.instantiate()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc private func skipLoggin() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.window?.rootViewController = TabbarViewController()
    }
    
    private func showLoginAlert() {
        self.showLoginAlert(title: "Thông báo", description: "Đăng nhập Google thất bại. \n Vui lòng thử lại sau.")
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        startAnimationLoading()
        /// Login Success -> Save user data and move to main screen
        if user != nil {
            if let auth = user.authentication {
                let credential = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
                Auth.auth().signInAndRetrieveData(with: credential, completion: { (user, _) in
                    /** Save data in local
                     Save user data to Firebas
                     Move to main screen
                     TODO: Kiểm tra nếu đã tồn tại ở db thì sẽ ko ghi lại người dùng này nữa, tránh trùng lặp
                     */
                    self.ref = Database.database().reference()
                    if let userInfo = user?.user {
                        guard let photoUrl = userInfo.photoURL?.absoluteString else { return }
                        self.ref.child("users").child(userInfo.uid).setValue(["email": userInfo.email, "name": userInfo.displayName, "photoUrl": photoUrl], withCompletionBlock: { (err, _) in
                            if err != nil {
                                self.showLoginAlert()
                            }
                            self.stopAnimationLoading()
                            /// Todo: Save user data to local
                            let account = Account()
                            account.email = userInfo.email
                            account.userName = userInfo.displayName
                            account.uid = userInfo.uid
                            account.photoUrl = userInfo.photoURL == nil ? "https://lh5.googleusercontent.com/-LL8cv_YA_g8/AAAAAAAAAAI/AAAAAAAABVQ/X6R24hrLPDs/s96-c/photo.jpg" : userInfo.photoURL?.absoluteString
                            let realm = try? Realm()
                            do {
                                try realm?.write {
                                    realm?.add(account)
                                }
                            } catch let realmErr {
                                print(realmErr)
                            }
                            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                            appDelegate.window?.rootViewController = TabbarViewController()
                        })
                    } else {
                        self.stopAnimationLoading()
                        self.showLoginAlert()
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
                    self.showLoginAlert()
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
