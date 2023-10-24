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
        self.signinFailedMessageLabel.isHidden = true
        self.signinButton.isEnabled = false
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */

    @IBAction func didTapSigninButton(_: Any) {
        // TODO: SendVCに遷移
    }

    @IBAction func didTapSignupButton(_: Any) {
        // TODO: SignupVCに遷移
        // stortboardを指定
        let storyboard = UIStoryboard(name: "SignupViewController", bundle: nil)
        // ViewControllerをインスタンス化
        let viewController = storyboard.instantiateViewController(identifier: "SignupVC") as! SignupViewController
        // NavigationControllerを指定
        let navigationController = UINavigationController(rootViewController: viewController)
        // モーダル遷移が画面全体になるように指定
        navigationController.modalPresentationStyle = .fullScreen
        // 遷移
        present(navigationController, animated: true)
    }
}
