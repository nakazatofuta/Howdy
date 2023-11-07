//
//  SignupViewController.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/10/22.
//

import UIKit

class SignupViewController: UIViewController {
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var changeGuideLabel: UILabel!
    @IBOutlet private weak var mailAdressField: UITextField!
    @IBOutlet private weak var usernameField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var signupButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setDismissKeyboard()
        setupNavigationBar()
    }

    @IBAction func didTapSignupButton(_: Any) {
        // TopVCに遷移
        modalTransition(storyboardName: "TopViewController", viewControllerName: "TopNC")
    }
}
