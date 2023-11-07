//
//  RecordViewController.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/10/22.
//

import UIKit

class RecordViewController: UIViewController {
    @IBOutlet private var destinationProfileImage: UIImageView!
    @IBOutlet private var destinationUsernameLabel: UILabel!
    @IBOutlet private var recordingProgressBar: UIProgressView!
    @IBOutlet private var recordingStatusButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }

    @IBAction func didTapSendButton(_: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
