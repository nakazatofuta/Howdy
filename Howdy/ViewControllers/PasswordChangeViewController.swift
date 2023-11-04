//
//  PasswordChangeViewController.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/10/22.
//

import UIKit

class PasswordChangeViewController: UIViewController {
    @IBOutlet weak var mailAdressLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationBarModel().setupNavigationBar(viewController: self)
    }

    @IBAction func didTapResetEmailSendButton(_: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
