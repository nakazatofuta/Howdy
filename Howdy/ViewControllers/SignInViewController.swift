//
//  SignInViewController.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/10/22.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet private weak var signInFailedMessageLabel: UILabel!
    @IBOutlet private weak var mailAddressField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var passwordForgottenButton: UIButton!
    @IBOutlet private weak var signInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setDismissKeyboard()
        setupNavigationBar()
        self.navigationItem.titleView?.isHidden = true
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "サインイン", style: .plain, target: nil, action: nil)

        self.signInFailedMessageLabel.isHidden = true
        // TODO: changestatusメソッド呼び出し
    }

    @IBAction func didTapPasswordForgottenButton(_: Any) {
        // PasswordForgottenVCに遷移
        pushTransition(storyboardName: "PasswordForgottenViewController", viewControllerName: "PasswordForgottenVC")
    }

    @IBAction func didTapSignInButton(_: Any) {
        // TopVCに遷移
        modalTransition(storyboardName: "TopViewController", viewControllerName: "TopNC")
    }

    @IBAction func didTapSignUpButton(_: Any) {
        // SignUpVCに遷移
        pushTransition(storyboardName: "SignUpViewController", viewControllerName: "SignUpVC")
    }
}
