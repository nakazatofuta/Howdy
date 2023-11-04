//
//  AppDelegate.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/10/12.
//

import IQKeyboardManagerSwift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        // NavigationBarフォント設定
        for controlState in [UIControl.State.normal, UIControl.State.disabled, UIControl.State.focused, UIControl.State.highlighted, UIControl.State.selected] {
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Corporate-Logo-Medium-ver3", size: 18)!], for: controlState)
        }

        if true {
            // windowを宣言
            self.window = UIWindow(frame: UIScreen.main.bounds)
            // storyboardを宣言
            let storyboard = UIStoryboard(name: "SigninViewController", bundle: Bundle.main)
            // rootViewControllerを宣言
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "SigninNC")
            // windowのrootViewControllerを設定
            self.window?.rootViewController = rootViewController
            // windowの背景を白にする
            self.window?.backgroundColor = UIColor.accent
            // 遷移
            self.window?.makeKeyAndVisible()
        } else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "TopViewController", bundle: Bundle.main)
            // rootViewControllerを宣言
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "TopNC")
            self.window?.rootViewController = rootViewController
            self.window?.backgroundColor = UIColor.accent
            self.window?.makeKeyAndVisible()
        }

        return true
    }
}
