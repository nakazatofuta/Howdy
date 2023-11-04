//
//  SignupViewController.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/10/22.
//

import UIKit

class SignupViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var changeGuideLabel: UILabel!
    @IBOutlet weak var mailAdressField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signupButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationBarModel().setupNavigationBar(viewController: self)
    }

    @IBAction func didTapSignupButton(_: Any) {
        // SendVCに遷移
        ScreenTransitionModel().modalTransition(viewController: self, storyboardName: "SendViewController", viewControllerName: "SendNC")
    }
}
