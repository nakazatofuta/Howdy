//
//  SendViewController.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/10/22.
//

import UIKit

class SendViewController: UIViewController {
    @IBOutlet var destinationProfileImage: UIImageView!
    @IBOutlet var destinationUsernameField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = UIImageView(image: UIImage(named: "NavigationBarLogo.png"))
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }

    @IBAction func didTapSearchButton(_: Any) {
        // TODO: RecordVCに遷移
    }
}
