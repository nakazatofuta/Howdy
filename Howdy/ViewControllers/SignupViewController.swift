//
//  SignupViewController.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/10/22.
//

import UIKit

class SignupViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var changeGuideLabel: UILabel!
    @IBOutlet weak var mailAdressField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signupButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = UIImageView(image: UIImage(named: "NavigationBarLogo.png"))
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        UIBarButtonItem.appearance()
            .setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Corporate-Logo-Medium-ver3", size: 20)!],
                                    for: .normal)
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
    @IBAction func didTapCancelButton(_: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
