//
//  SettingViewController.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/10/22.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let viewModel = SettingViewModel()
    let settingItems = ["MyHowdyIDの確認", "ユーザー名の変更", "プロフィール画像の変更", "メールアドレスの変更", "パスワードの変更"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return settingItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as? SettingTableViewCell {
            cell.settingItemLabel.text = settingItems[indexPath.row]
            return cell
        } else {
            return UITableViewCell()
        }
    }

    // セルがタップされた時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)

        switch indexPath.row {
        case 0:
            // MyIDConfirmVCに遷移
            pushTransition(storyboardName: "MyIDConfirmViewController", viewControllerName: "MyIDConfirmVC")
        case 1:
            return
        case 2:
            return
        case 3:
            return
        case 4:
            // PasswordChangeVCに遷移
            pushTransition(storyboardName: "PasswordChangeViewController", viewControllerName: "PasswordChangeVC")
        default:
            return
        }
    }

    @IBAction func didTapSignOutButton(_: Any) {
        viewModel.signOut { success in
            if success {
                // SignInNCに遷移
                self.modalTransition(storyboardName: "SignInViewController", viewControllerName: "SignInNC")
            } else {
                return
            }
        }
    }
}
