//
//  RecordViewController.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/10/22.
//

import UIKit

class RecordViewController: UIViewController {
    @IBOutlet weak var destinationProfileImage: UIImageView!
    @IBOutlet weak var destinationUsernameLabel: UILabel!
    @IBOutlet weak var recordingProgressBar: UIProgressView!
    @IBOutlet weak var recordingStatusButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
    @IBAction func didTapSendButton(_: Any) {}
}
