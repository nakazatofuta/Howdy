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

        // 画像を設定
        let imageView = UIImageView(image: UIImage(named: "NavigationBarLogo.png"))
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView

        // ボタンのフォント設定
        for controlState in [UIControl.State.normal, UIControl.State.disabled, UIControl.State.focused, UIControl.State.highlighted, UIControl.State.selected] {
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Corporate-Logo-Medium-ver3", size: 18)!], for: controlState)
        }
    }

    @IBAction func didTapCancelButton(_: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
