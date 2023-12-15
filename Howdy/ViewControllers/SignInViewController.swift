//
//  SignInViewController.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/10/22.
//

import FirebaseAuth
import NVActivityIndicatorView
import RxCocoa
import RxSwift
import UIKit

class SignInViewController: UIViewController {
    @IBOutlet private weak var signInFailedMessageLabel: UILabel!
    @IBOutlet private weak var mailAddressField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var passwordForgottenButton: UIButton!
    @IBOutlet private weak var signInButton: UIButton!

    private var activityIndicatorView: NVActivityIndicatorView!
    private let viewModel = SignInViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Indicator設定
        activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50), type: NVActivityIndicatorType.lineScale, color: .accent, padding: 0)
        activityIndicatorView.center = view.center
        view.addSubview(activityIndicatorView)
        // キーボード設定
        setDismissKeyboard()
        // Navigation設定
        setupNavigationBar()
        navigationItem.titleView?.isHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "サインイン", style: .plain, target: nil, action: nil)
        // 画面パーツ活性設定
        signInFailedMessageLabel.isHidden = true
        changeSignUpButtonStatus()
        // RxSwiftでの監視
        validTxtField(textField: mailAddressField)
        validTxtField(textField: passwordField)
    }

    // テキストフィールドの変更を監視
    private func validTxtField(textField: UITextField) {
        // textの変更を検知する
        textField.rx.text.subscribe(onNext: { _ in
            self.changeSignUpButtonStatus()
        }).disposed(by: disposeBag)
    }

    private func changeSignUpButtonStatus() {
        guard let mailAddress = mailAddressField.text, let password = passwordField.text else {
            return
        }
        if mailAddress.count > 0, password.count >= 6 {
            signInButton.isEnabled = true
        } else {
            signInButton.isEnabled = false
        }
    }

    @IBAction func didTapPasswordForgottenButton(_: Any) {
        // PasswordForgottenVCに遷移
        pushTransition(storyboardName: "PasswordForgottenViewController", viewControllerName: "PasswordForgottenVC")
    }

    @IBAction func didTapSignInButton(_: Any) {
        self.signInFailedMessageLabel.isHidden = true
        activityIndicatorView.startAnimating()
        // Firebaseサインイン処理
        guard let mailAddress = mailAddressField.text, let password = passwordField.text else {
            activityIndicatorView.stopAnimating()
            return
        }
        viewModel.signIn(email: mailAddress, password: password, result: { success, error in
            if success {
                self.activityIndicatorView.stopAnimating()
                self.signInFailedMessageLabel.isHidden = true
                // TopVCに遷移
                self.modalTransition(storyboardName: "TopViewController", viewControllerName: "TopNC")
            } else {
                self.activityIndicatorView.stopAnimating()
                if error?.code == 17999 {
                    self.signInFailedMessageLabel.isHidden = false
                } else if error?.code == 17008 {
                    self.showErrorDialog(title: "メールアドレスが不適切です", message: "正しいメールアドレスを入力してください")
                } else {
                    self.showErrorDialog(title: "エラー", message: "しばらくしてからもう一度実行してください")
                }
            }
        })
    }

    func showErrorDialog(title: String, message: String) {
        let dialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "OK", style: .default))
        dialog.view.tintColor = UIColor.accent
        present(dialog, animated: true)
    }

    @IBAction func didTapSignUpButton(_: Any) {
        // SignUpVCに遷移
        pushTransition(storyboardName: "SignUpViewController", viewControllerName: "SignUpVC")
    }
}
