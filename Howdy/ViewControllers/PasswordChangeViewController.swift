//
//  PasswordChangeViewController.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/10/22.
//

import UIKit

class PasswordChangeViewController: UIViewController {
    @IBOutlet private weak var mailAddressLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }

    @IBAction func didTapResetEmailSendButton(_: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
