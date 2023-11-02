//
//  ReceiveViewController.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/10/22.
//

import UIKit

class ReceiveViewController: UIViewController {
    @IBOutlet weak var voiceMessageTableVIew: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = UIImageView(image: UIImage(named: "NavigationBarLogo.png"))
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView

        // ToolBarを隠す
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
}
