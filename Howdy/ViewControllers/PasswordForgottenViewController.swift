//
//  PasswordForgottenViewController.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/10/22.
//

import UIKit

class PasswordForgottenViewController: UIViewController {
    @IBOutlet private weak var mailAdressField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setDismissKeyboard()
        setupNavigationBar()
    }

    @IBAction func didTapResetEmailSendButton(_: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
