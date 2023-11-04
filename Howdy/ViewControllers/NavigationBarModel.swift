//
//  NavigationBarModel.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/11/04.
//

import UIKit

class NavigationBarModel {
    func setupNavigationBar(viewController: UIViewController) {
        // 画像を設定
        let imageView = UIImageView(image: UIImage(named: "NavigationBarLogo.png"))
        imageView.contentMode = .scaleAspectFit
        viewController.navigationItem.titleView = imageView

        // ToolBarを隠す
        viewController.navigationController?.setToolbarHidden(true, animated: false)
    }
}
