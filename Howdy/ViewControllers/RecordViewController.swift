//
//  RecordViewController.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/10/22.
//

import UIKit

class RecordViewController: UIViewController {
    @IBOutlet var destinationProfileImage: UIImageView!
    @IBOutlet var destinationUsernameLabel: UILabel!
    @IBOutlet var recordingProgressBar: UIProgressView!
    @IBOutlet var recordingStatusButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationBarModel().setupNavigationBar(viewController: self)
    }

    @IBAction func didTapSendButton(_: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
