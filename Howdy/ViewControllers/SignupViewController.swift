//
//  SignupViewController.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/10/22.
//

import RxCocoa
import RxSwift
import UIKit

class SignupViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var changeGuideLabel: UILabel!
    @IBOutlet private weak var mailAddressField: UITextField!
    @IBOutlet private weak var usernameField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var privacyPolicyButton: UIButton!
    @IBOutlet private weak var signupButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDismissKeyboard()
        setupNavigationBar()
        changeSignupButtonStatus()
        
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
            self.changeSignupButtonStatus()
        }).disposed(by: disposeBag)
    }
    
    private func changeSignupButtonStatus() {
        if mailAddressField.text!.count > 0, usernameField.text!.count > 0, passwordField.text!.count >= 6 {
            signupButton.isEnabled = true
        } else {
            signupButton.isEnabled = false
        }
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
        // TODO: Firebaseへのユーザー登録処理
        // TODO: APIで*があればエラー
        usernameValidation(username: usernameField.text!)
        // TODO: 既に同一の名前のユーザーが存在すればエラー
        // TopVCに遷移
        modalTransition(storyboardName: "TopViewController", viewControllerName: "TopNC")
    }
    
    func usernameValidation(username: String) {
        let apiUrl = "https://www.purgomalum.com/service/json?text=\(username)"
        performRequest(urlString: apiUrl)
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, error in
                if error != nil {
                    print("Error:\(error!)")
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(validatedResult: safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(validatedResult: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(UsernameData.self, from: validatedResult)
            print(decodedData.result)
        } catch {
            print("Error:\(error)")
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
}
