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
    @IBOutlet weak var passwordForgottenLabel: UILabel!
    @IBOutlet weak var signinButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.signinFailedMessageLabel.isHidden = false
        self.signinButton.isEnabled = true

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "サインイン", style: .plain, target: nil, action: nil)

        // ToolBarを隠す
        self.navigationController?.setToolbarHidden(true, animated: false)
    }

    @IBAction func didTapSigninButton(_: Any) {
        // SendVCに遷移
        // stortboardを指定
        let storyboard = UIStoryboard(name: "SendViewController", bundle: Bundle.main)
        // ViewControllerをインスタンス化
        let viewController = storyboard.instantiateViewController(identifier: "SendNC")
        // モーダル遷移スタイル指定
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        // 遷移
        present(viewController, animated: true)
    }

    @IBAction func didTapSignupButton(_: Any) {
        // SignupVCに遷移
        // stortboardを指定
        let storyboard = UIStoryboard(name: "SignupViewController", bundle: nil)
        // ViewControllerをインスタンス化
        let viewController = storyboard.instantiateViewController(identifier: "SignupVC") as! SignupViewController
        // push遷移
        navigationController?.pushViewController(viewController, animated: true)
    }
}
