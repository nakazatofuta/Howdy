//
//  TopViewController.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/10/22.
//

import FirebaseFirestoreInternal
import NVActivityIndicatorView
import RxCocoa
import RxSwift
import UIKit

class TopViewController: UIViewController {
    @IBOutlet private weak var navigationBarProfileButton: UIBarButtonItem!
    @IBOutlet private weak var segmentController: UISegmentedControl!
    // sendView
    @IBOutlet private var destinationProfileImage: UIImageView!
    @IBOutlet weak var destinationUsernameLabel: UILabel!
    @IBOutlet private var destinationIdField: UITextField!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var confirmButton: UIButton!
    // receiveView
    // view
    @IBOutlet private var sendView: UIView!
    @IBOutlet private var receiveView: UIView!

    private var segmentControllerHeightDisplacement: CGFloat = 0.0

    private var activityIndicatorView: NVActivityIndicatorView!
    private let disposeBag = DisposeBag()
    let database = DatabaseHelper()

    // MARK: - common

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSegmentController()
        // Indicator設定
        self.activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50), type: NVActivityIndicatorType.lineScale, color: .accent, padding: 0)
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        self.activityIndicatorView.center = CGPoint(x: screenWidth / 2,
                                                    y: screenHeight / 2 - self.segmentControllerHeightDisplacement)
        self.sendView.addSubview(self.activityIndicatorView)
        setDismissKeyboard()
        setupNavigationBar()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        self.setupImageView()
        self.destinationUsernameLabel.text = ""
        self.changeSearchButtonStatus()
        // RxSwiftでの監視
        self.validTxtField(textField: self.destinationIdField)
    }

    func setupImageView() {
        self.destinationProfileImage.clipsToBounds = true
        self.destinationProfileImage.layer.cornerRadius = self.destinationProfileImage.frame.width / 2
    }

    func setupSegmentController() {
        self.segmentController.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Corporate-Logo-Medium-ver3", size: 13)!], for: .normal)
        self.segmentController.setTitle("送信", forSegmentAt: 0)
        self.segmentController.setTitle("受け取る", forSegmentAt: 1)
        self.segmentControllerHeightDisplacement = self.segmentController.frame.height + self.segmentController.frame.minY
        // 追加するViewのHeightがSegmentの下につくように設定
        self.sendView.frame = CGRect(x: 0,
                                     y: self.segmentControllerHeightDisplacement,
                                     width: self.view.frame.width,
                                     height: self.view.frame.height - self.segmentController.frame.minY)
        self.receiveView.frame = CGRect(x: 0,
                                        y: self.segmentControllerHeightDisplacement,
                                        width: self.view.frame.width,
                                        height: self.view.frame.height - self.segmentController.frame.minY)
        // デフォルトでsendViewを表示
        self.view.addSubview(self.sendView)
    }

    // receiveViewをViewから削除し、sendViewをViewに追加する
    func addSendViewController() {
        self.receiveView.removeFromSuperview()
        self.view.addSubview(self.sendView)
    }

    // sendViewControllerをViewから削除し、receiveViewControllerをViewに追加する
    func addReceiveViewController() {
        self.sendView.removeFromSuperview()
        self.view.addSubview(self.receiveView)
    }

    @IBAction func didTapNavigationBarProfileButton(_: Any) {
        // SettingVCに遷移
        pushTransition(storyboardName: "SettingViewController", viewControllerName: "SettingVC")
    }

    @IBAction func didTapSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            // Firstをタップされた時に実行される処理
            self.addSendViewController()
        case 1:
            // Secondをタップされた時に実行される処理
            self.addReceiveViewController()
        default:
            // デフォルトで実行される処理
            self.addSendViewController()
        }
    }

    // MARK: - sendView

    // テキストフィールドの変更を監視
    private func validTxtField(textField: UITextField) {
        // textの変更を検知する
        textField.rx.text.subscribe(onNext: { _ in
            self.confirmButton.isEnabled = false
            self.changeSearchButtonStatus()
        }).disposed(by: self.disposeBag)
    }

    private func changeSearchButtonStatus() {
        guard let destinationId = destinationIdField.text else {
            return
        }
        if destinationId.count > 0 {
            self.searchButton.isEnabled = true
        } else {
            self.searchButton.isEnabled = false
        }
    }

    @IBAction func didTapSearchButton(_: Any) {
        guard let destinationId = destinationIdField.text else {
            return
        }
        self.activityIndicatorView.startAnimating()
        self.confirmButton.isEnabled = false
        self.idSearch(id: destinationId)
    }

    private func idSearch(id: String) {
        self.database.getUserInfo(userId: id, completionHandler: { username, success in
            self.destinationProfileImage.image = UIImage(named: "DefaultProfileImage")
            self.destinationUsernameLabel.text = ""
            self.activityIndicatorView.stopAnimating()
            if success {
                if username.isEmpty {
                    self.showErrorDialog(title: "ユーザーが見つかりません", message: "入力ミスがないか、\nもう一度ご確認ください")
                } else {
                    self.destinationUsernameLabel.text = username
                    self.database.getProfileImage(userId: id, imageView: self.destinationProfileImage)
                    self.confirmButton.isEnabled = true
                }
            } else {
                self.showErrorDialog(title: "エラー", message: "しばらくしてからもう一度実行してください")
            }
        })
    }

    func showErrorDialog(title: String, message: String) {
        let dialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "OK", style: .default))
        dialog.view.tintColor = UIColor.accent
        present(dialog, animated: true)
    }

    @IBAction func didTapConfirmButton(_: Any) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "宛先検索", style: .plain, target: nil, action: nil)
        // RecordVCに遷移
        pushTransition(storyboardName: "RecordViewController", viewControllerName: "RecordVC")
    }

    @IBAction func didTapQRScanButton(_: Any) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "ID入力", style: .plain, target: nil, action: nil)
        // QRScannerVCに遷移
        pushTransition(storyboardName: "QRScannerViewController", viewControllerName: "QRScannerVC")
    }

    // MARK: - receiveView
}
