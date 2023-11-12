//
//  PrivacyPolicyViewController.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/11/12.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {
    @IBOutlet weak var privacyPolicyTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        privacyPolicyTextView.isEditable = false
        privacyPolicyTextView.dataDetectorTypes = UIDataDetectorTypes.link
    }
}
