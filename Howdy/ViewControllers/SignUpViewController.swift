//
//  SignUpViewController.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/10/22.
//

import CropViewController
import FirebaseAuth
import NVActivityIndicatorView
import RxCocoa
import RxSwift
import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CropViewControllerDelegate {
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var changeGuideLabel: UILabel!
    @IBOutlet private weak var mailAddressField: UITextField!
    @IBOutlet private weak var usernameField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var privacyPolicyButton: UIButton!
    @IBOutlet private weak var signupButton: UIButton!
    
    private var activityIndicatorView: NVActivityIndicatorView!
    private let viewModel = SignUpViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50), type: NVActivityIndicatorType.lineScale, color: .accent, padding: 0)
        activityIndicatorView.center = view.center
        view.addSubview(activityIndicatorView)
        setDismissKeyboard()
        setupNavigationBar()
        changeSignUpButtonStatus()
        
        validTxtField(textField: mailAddressField)
        validTxtField(textField: usernameField)
        validTxtField(textField: passwordField)
        
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onImage)))
    }
    
    // テキストフィールドの変更を監視
    private func validTxtField(textField: UITextField) {
        // textの変更を検知する
        textField.rx.text.subscribe(onNext: { _ in
            self.changeSignUpButtonStatus()
        }).disposed(by: disposeBag)
    }
    
    private func changeSignUpButtonStatus() {
        guard let mailAddress = mailAddressField.text, let username = usernameField.text, let password = passwordField.text else {
            return
        }
        if mailAddress.count > 0, username.count > 0, password.count >= 6 {
            signupButton.isEnabled = true
        } else {
            signupButton.isEnabled = false
        }
    }
    
    @objc func onImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let pickedImage = info[.originalImage] as? UIImage else {
            return
        }
        let cropViewController = CropViewController(croppingStyle: .circular, image: pickedImage)
        cropViewController.delegate = self
        cropViewController.customAspectRatio = profileImage.frame.size
        picker.dismiss(animated: true) {
            self.present(cropViewController, animated: true)
        }
    }
    
    @IBAction func didTapSignUpButton(_: Any) {
        guard let username = usernameField.text else {
            return
        }
        activityIndicatorView.startAnimating()
        // usernameに*があればエラー
        viewModel.usernameValidation(username: username) { result, error in
            DispatchQueue.main.async {
                if result != nil {
                    guard let result = result else {
                        return
                    }
                    if result.contains("*") {
                        self.activityIndicatorView.stopAnimating()
                        self.showErrorDialog(title: "ユーザー名が不適切です", message: "公序良俗に反するユーザー名は使用できません")
                    } else {
                        // Firebase新規登録処理
                        guard let mailAddress = self.mailAddressField.text, let password = self.passwordField.text else {
                            return
                        }
                        self.viewModel.signup(email: mailAddress, password: password, result: { success, error in
                            if success {
                                self.createImageToFirebaseStorage { success in
                                    if success {
                                        self.activityIndicatorView.stopAnimating()
                                        // TopVCに遷移
                                        self.modalTransition(storyboardName: "TopViewController", viewControllerName: "TopNC")
                                    }
                                    self.activityIndicatorView.stopAnimating()
                                    self.showErrorDialog(title: "エラー", message: "もう一度やり直してください")
                                }
                                
                            } else {
                                self.activityIndicatorView.stopAnimating()
                                if error?.code == 17007 {
                                    self.showErrorDialog(title: "このメールアドレスは使用できません", message: "このメールアドレスは既に使用されています\n別のメールアドレスを選択してください")
                                } else {
                                    self.showErrorDialog(title: "エラー", message: "正しいメールアドレスを入力してください")
                                }
                            }
                        })
                    }
                }
            }
            if error != nil {
                self.activityIndicatorView.stopAnimating()
                self.showErrorDialog(title: "エラー", message: "もう一度やり直してください")
            }
        }
    }
    
    private func createImageToFirebaseStorage(completionHandler: @escaping (Bool) -> Void) {
        let uid = viewModel.userModel.uid()
        let uploadImage: Data?
        // プロフィール画像が設定されている場合の処理
        if let image = profileImage.image {
            uploadImage = image.jpegData(compressionQuality: 0.1)
            guard let uploadImage = uploadImage else {
                return
            }
            // FirebaseStorageへ保存
            viewModel.createImage(uid: uid, uploadImage: uploadImage) { success in
                if success {
                    completionHandler(true)
                }
                completionHandler(false)
            }
        }
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
        let privacyPolicyVC = storyboard.instantiateViewController(withIdentifier: "PrivacyPolicyVC")
        privacyPolicyVC.modalPresentationStyle = .formSheet
        present(privacyPolicyVC, animated: true, completion: nil)
    }
    
    func cropViewController(_ cropViewController: CropViewController, didCropToCircularImage image: UIImage, withRect _: CGRect, angle _: Int) {
        // トリミング編集が終えたら、呼び出される。
        updateImageViewWithImage(image, fromCropViewController: cropViewController)
    }
        
    func updateImageViewWithImage(_ image: UIImage, fromCropViewController cropViewController: CropViewController) {
        // トリミングした画像をimageViewのimageに代入する。
        profileImage.image = image
        changeGuideLabel.isHidden = true
        cropViewController.dismiss(animated: true, completion: nil)
    }
}
