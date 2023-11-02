//
//  SendViewController.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/10/22.
//

import UIKit

class SendViewController: UIViewController {
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet var destinationProfileImage: UIImageView!
    @IBOutlet var destinationUsernameField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = UIImageView(image: UIImage(named: "NavigationBarLogo.png"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView

        segmentController.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Corporate-Logo-Medium-ver3", size: 13)!], for: .normal)
        segmentController.setTitle("送信", forSegmentAt: 0)
        segmentController.setTitle("受け取る", forSegmentAt: 1)

        // ToolBarを隠す
        navigationController?.setToolbarHidden(true, animated: false)
    }

    @IBAction func didTapSearchButton(_: Any) {
        // RecordVCに遷移
        // stortboardを指定
        let storyboard = UIStoryboard(name: "RecordViewController", bundle: nil)
        // ViewControllerをインスタンス化
        let viewController = storyboard.instantiateViewController(identifier: "RecordVC") as! RecordViewController
        // push遷移
        navigationController?.pushViewController(viewController, animated: true)
    }
}
