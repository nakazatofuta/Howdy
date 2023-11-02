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
        let imageView = UIImageView(image: UIImage(named: "NavigationBarLogo.png"))
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView

        // ToolBarを隠す
        self.navigationController?.setToolbarHidden(true, animated: false)
    }

    @IBAction func didTapSendButton(_: Any) {}
}
