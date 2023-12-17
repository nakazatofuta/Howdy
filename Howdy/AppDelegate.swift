//
//  AppDelegate.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/10/12.
//

import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import IQKeyboardManagerSwift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()
        // NavigationBarフォント設定
        for controlState in [
            UIControl.State.normal,
            UIControl.State.disabled,
            UIControl.State.focused,
            UIControl.State.highlighted,
            UIControl.State.selected,
        ] {
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Corporate-Logo-Medium-ver3", size: 18)!], for: controlState)
        }

        if UserModel().uid().isEmpty {
            // windowを宣言
            window = UIWindow(frame: UIScreen.main.bounds)
            // storyboardを宣言
            let storyboard = UIStoryboard(name: "SignInViewController", bundle: Bundle.main)
            // rootViewControllerを宣言
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "SignInNC")
            // windowのrootViewControllerを設定
            window?.rootViewController = rootViewController
            // windowの背景を黒にする
            window?.backgroundColor = UIColor.black
            // 遷移
            window?.makeKeyAndVisible()
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "TopViewController", bundle: Bundle.main)
            // rootViewControllerを宣言
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "TopNC")
            window?.rootViewController = rootViewController
            window?.backgroundColor = UIColor.accent
            window?.makeKeyAndVisible()
        }

        return true
    }
}
