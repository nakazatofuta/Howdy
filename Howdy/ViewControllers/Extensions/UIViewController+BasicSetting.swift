//
//  UIViewController+BasicSetting.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/11/04.
//

import UIKit

extension UIViewController {
    // キーボード閉じる
    func setDismissKeyboard() {
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGR.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGR)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    // NavigationBarセットアップ
    func setupNavigationBar() {
        // タイトル画像設定
        let imageView = UIImageView(image: UIImage(named: "NavigationBarLogo.png"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView

        // ToolBarを隠す
        navigationController?.setToolbarHidden(true, animated: false)
    }

    // モーダル遷移
    func modalTransition(storyboardName: String, viewControllerName: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(identifier: viewControllerName)
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        present(viewController, animated: true)
    }

    // プッシュ遷移
    func pushTransition(storyboardName: String, viewControllerName: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: viewControllerName)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
