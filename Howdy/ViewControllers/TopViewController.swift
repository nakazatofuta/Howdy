//
//  TopViewController.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/10/22.
//

import UIKit

class TopViewController: UIViewController {
    @IBOutlet weak var navigationBarProfileButton: UIBarButtonItem!
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet var destinationProfileImage: UIImageView!
    @IBOutlet var destinationUsernameField: UITextField!

    @IBOutlet var sendView: UIView!
    @IBOutlet var receiveView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setDismissKeyboard()
        setupNavigationBar()
        self.setupSegmentController()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    }

    func setupSegmentController() {
        self.segmentController.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Corporate-Logo-Medium-ver3", size: 13)!], for: .normal)
        self.segmentController.setTitle("送信", forSegmentAt: 0)
        self.segmentController.setTitle("受け取る", forSegmentAt: 1)

        // 追加するViewのHeightがSegumentの下につくように設定
        self.sendView.frame = CGRect(x: 0,
                                     y: self.segmentController.frame.minY + self.segmentController.frame.height,
                                     width: self.view.frame.width,
                                     height: self.view.frame.height - self.segmentController.frame.minY)
        self.receiveView.frame = CGRect(x: 0,
                                        y: self.segmentController.frame.minY + self.segmentController.frame.height,
                                        width: self.view.frame.width,
                                        height: self.view.frame.height - self.segmentController.frame.minY)
        // デフォルトでsendViewを表示
        self.view.addSubview(self.sendView)
    }

    // receiveViewをViewから削除し、sendViewをViewに追加する
    func addsendViewController() {
        self.receiveView.removeFromSuperview()
        self.view.addSubview(self.sendView)
    }

    // sendViewControllerをViewから削除し、receiveViewControllerをViewに追加する
    func addreceiveViewController() {
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
            self.addsendViewController()
        case 1:
            // Secondをタップされた時に実行される処理
            self.addreceiveViewController()
        default:
            // デフォルトで実行される処理
            self.addsendViewController()
        }
    }

    @IBAction func didTapSearchButton(_: Any) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "宛先入力", style: .plain, target: nil, action: nil)
        // RecordVCに遷移
        pushTransition(storyboardName: "RecordViewController", viewControllerName: "RecordVC")
    }
}
