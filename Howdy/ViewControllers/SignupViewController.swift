//
//  SignupViewController.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/10/22.
//

import UIKit

class SignupViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var changeGuideLabel: UILabel!
    @IBOutlet private weak var mailAdressField: UITextField!
    @IBOutlet private weak var usernameField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var privacyPolicyButton: UIButton!
    @IBOutlet private weak var signupButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setDismissKeyboard()
        setupNavigationBar()
        signupButton.isEnabled = false

        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onImage)))
    }

    @objc func onImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.mediaTypes = ["public.image"]
        picker.delegate = self
        present(picker, animated: true)
    }

    func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        profileImage.image = image
        changeGuideLabel.isHidden = true
        dismiss(animated: true)
    }

    @IBAction func didTapSignupButton(_: Any) {
//        guard let username = usernameField.text, let password = passwordField.text else {
//            return
//        }
//        if password.count < 6 {
//            showErrorDialog(title: "パスワードが不適切です", message: "パスワードは6文字以上で入力してください")
//            return
//        }
        // TopVCに遷移
        modalTransition(storyboardName: "TopViewController", viewControllerName: "TopNC")
    }

    func showErrorDialog(title: String, message: String) {
        let dialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "OK", style: .default))
        dialog.view.tintColor = UIColor.accent
        present(dialog, animated: true)
    }

    @IBAction func didTapPrivacyPolicyButton(_: Any) {
        // PrivacyPolicyVCに遷移
        let storyboard = UIStoryboard(name: "PrivacyPolicyViewController", bundle: nil)
        let PrivacyPolicyVC = storyboard.instantiateViewController(withIdentifier: "PrivacyPolicyVC")
        PrivacyPolicyVC.modalPresentationStyle = .formSheet
        present(PrivacyPolicyVC, animated: true, completion: nil)
    }
}
