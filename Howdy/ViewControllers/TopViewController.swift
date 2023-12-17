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

    let viewModel = TopViewModel()

    private var segmentControllerHeightDisplacement: CGFloat = 0.0

    private var activityIndicatorView: NVActivityIndicatorView!
    private let disposeBag = DisposeBag()
    let database = DatabaseHelper()

    // MARK: - common

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentController()
        // Indicator設定
        activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50), type: NVActivityIndicatorType.lineScale, color: .accent, padding: 0)
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        activityIndicatorView.center = CGPoint(x: screenWidth / 2,
                                               y: screenHeight / 2 - segmentControllerHeightDisplacement)
        sendView.addSubview(activityIndicatorView)
        setDismissKeyboard()
        setupNavigationBar()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        print("top:\(UserInfo.profileImage)")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UserInfo.profileImage?.withRenderingMode(.alwaysOriginal),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapNavigationBarProfileButton))
        setupImageView()
        // RxSwiftでの監視
        validTxtField(textField: destinationIdField)
    }

    override func viewWillAppear(_: Bool) {
        destinationProfileImage.image = UIImage(named: "DefaultProfileImage")
        destinationUsernameLabel.text = ""
        destinationIdField.text = viewModel.fetchScenResult()
        changeSearchButtonStatus()
        confirmButton.isEnabled = false
        viewModel.resetDestinationInformation()
    }

    func setupImageView() {
        destinationProfileImage.clipsToBounds = true
        destinationProfileImage.layer.cornerRadius = destinationProfileImage.frame.width / 2
    }

    func setupSegmentController() {
        segmentController.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Corporate-Logo-Medium-ver3", size: 13)!], for: .normal)
        segmentController.setTitle("送信", forSegmentAt: 0)
        segmentController.setTitle("受け取る", forSegmentAt: 1)
        segmentControllerHeightDisplacement = segmentController.frame.height + segmentController.frame.minY
        // 追加するViewのHeightがSegmentの下につくように設定
        sendView.frame = CGRect(x: 0,
                                y: segmentControllerHeightDisplacement,
                                width: view.frame.width,
                                height: view.frame.height - segmentController.frame.minY)
        receiveView.frame = CGRect(x: 0,
                                   y: segmentControllerHeightDisplacement,
                                   width: view.frame.width,
                                   height: view.frame.height - segmentController.frame.minY)
        // デフォルトでsendViewを表示
        view.addSubview(sendView)
    }

    // receiveViewをViewから削除し、sendViewをViewに追加する
    func addSendViewController() {
        receiveView.removeFromSuperview()
        view.addSubview(sendView)
    }

    // sendViewControllerをViewから削除し、receiveViewControllerをViewに追加する
    func addReceiveViewController() {
        sendView.removeFromSuperview()
        view.addSubview(receiveView)
    }

    @objc private func didTapNavigationBarProfileButton(_: Any) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "宛先検索", style: .plain, target: nil, action: nil)
        // SettingVCに遷移
        pushTransition(storyboardName: "SettingViewController", viewControllerName: "SettingVC")
    }

    @IBAction func didTapSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            // Firstをタップされた時に実行される処理
            addSendViewController()
        case 1:
            // Secondをタップされた時に実行される処理
            addReceiveViewController()
        default:
            // デフォルトで実行される処理
            addSendViewController()
        }
    }

    // MARK: - sendView

    // テキストフィールドの変更を監視
    private func validTxtField(textField: UITextField) {
        // textの変更を検知する
        textField.rx.text.subscribe(onNext: { _ in
            self.confirmButton.isEnabled = false
            self.changeSearchButtonStatus()
        }).disposed(by: disposeBag)
    }

    private func changeSearchButtonStatus() {
        guard let destinationId = destinationIdField.text else {
            return
        }
        if destinationId.count > 0 {
            searchButton.isEnabled = true
        } else {
            searchButton.isEnabled = false
        }
    }

    @IBAction func didTapSearchButton(_: Any) {
        guard let destinationId = destinationIdField.text else {
            return
        }
        activityIndicatorView.startAnimating()
        confirmButton.isEnabled = false
        idSearch(id: destinationId)
    }

    private func idSearch(id: String) {
        database.getUserInfo(userId: id, completionHandler: { username, success in
            self.destinationProfileImage.image = UIImage(named: "DefaultProfileImage")
            self.destinationUsernameLabel.text = ""
            if success {
                if username.isEmpty {
                    self.activityIndicatorView.stopAnimating()
                    self.showErrorDialog(title: "ユーザーが見つかりません", message: "入力ミスがないか、\nもう一度ご確認ください")
                } else {
                    self.destinationUsernameLabel.text = username
                    self.database.getProfileImage(userId: id, imageView: self.destinationProfileImage) { success in
                        self.activityIndicatorView.stopAnimating()
                        if success {
                            self.viewModel.registerDestinationInformation(username: username, profileImage: (self.destinationProfileImage.image ?? UIImage(named: "DefaultProfileImage"))!)
                            self.confirmButton.isEnabled = true
                        } else {
                            self.showErrorDialog(title: "エラー", message: "しばらくしてからもう一度実行してください")
                        }
                    }
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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "宛先検索", style: .plain, target: nil, action: nil)
        // RecordVCに遷移
        pushTransition(storyboardName: "RecordViewController", viewControllerName: "RecordVC")
    }

    @IBAction func didTapQRScanButton(_: Any) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "ID入力", style: .plain, target: nil, action: nil)
        // QRScannerVCに遷移
        pushTransition(storyboardName: "QRScannerViewController", viewControllerName: "QRScannerVC")
    }

    // MARK: - receiveView
}
