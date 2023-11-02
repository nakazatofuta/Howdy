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

        // ToolBarを隠す
        self.navigationController?.setToolbarHidden(true, animated: false)
    }

    @IBAction func didTapSignupButton(_: Any) {
        // SendVCに遷移
        let storyboard = UIStoryboard(name: "SendViewController", bundle: Bundle.main)
        // ViewControllerをインスタンス化
        let viewController = storyboard.instantiateViewController(identifier: "SendNC")
        // モーダル遷移スタイル指定
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        // 遷移
        present(viewController, animated: true)
    }
}
