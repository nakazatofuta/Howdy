//
//  SettingViewController.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/10/22.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let settingItems = ["ユーザー名の変更", "プロフィール画像の変更", "メールアドレスの変更", "パスワードの変更"]

    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationBarModel().setupNavigationBar(viewController: self)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return self.settingItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingTableViewCell
        cell.settingItemLabel.text = self.settingItems[indexPath.row]
        // セルに表示する値を設定する
        return cell
    }

    // セルがタップされた時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)

        switch indexPath.row {
        case 0:
            return
        case 1:
            return
        case 2:
            return
        case 3:
            // PasswordChangeVCに遷移
            // stortboardを指定
            let storyboard = UIStoryboard(name: "PasswordChangeViewController", bundle: nil)
            // ViewControllerをインスタンス化
            let viewController = storyboard.instantiateViewController(identifier: "PasswordChangeVC") as! PasswordChangeViewController
            // push遷移
            navigationController?.pushViewController(viewController, animated: true)
        default:
            return
        }
    }

    @IBAction func didTapSignoutButton(_: Any) {
        // SigninNCに遷移
        ScreenTransitionModel().modalTransition(viewController: self, storyboardName: "SigninViewController", viewControllerName: "SigninNC")
    }
}
