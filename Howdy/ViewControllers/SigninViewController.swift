//
//  SigninViewController.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/10/22.
//

import UIKit

class SigninViewController: UIViewController {
    @IBOutlet weak var signinFailedMessageLabel: UILabel!
    @IBOutlet weak var mailAdressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordForgottenButton: UIButton!
    @IBOutlet weak var signinButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationBarModel().setupNavigationBar(viewController: self)
        self.navigationItem.titleView?.isHidden = true
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "サインイン", style: .plain, target: nil, action: nil)

        self.signinFailedMessageLabel.isHidden = false
        self.signinButton.isEnabled = true
    }

    @IBAction func didTapPasswordForgottenButton(_: Any) {
        // PasswordForgottenVCに遷移
        ScreenTransitionModel().pushTransition(viewController: self, storyboardName: "PasswordForgottenViewController", viewControllerName: "PasswordForgottenVC")
    }

    @IBAction func didTapSigninButton(_: Any) {
        // SendVCに遷移
        ScreenTransitionModel().modalTransition(viewController: self, storyboardName: "SendViewController", viewControllerName: "SendNC")
    }

    @IBAction func didTapSignupButton(_: Any) {
        // SignupVCに遷移
        ScreenTransitionModel().pushTransition(viewController: self, storyboardName: "SignupViewController", viewControllerName: "SignupVC")
    }
}
