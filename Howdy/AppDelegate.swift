//
//  AppDelegate.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/10/12.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if true {
            // windowを生成
            self.window = UIWindow(frame: UIScreen.main.bounds)
            // Storyboardを指定
            let storyboard = UIStoryboard(name: "SigninViewController", bundle: nil)
            // Viewcontrollerを指定
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "SigninVC")
            // rootViewControllerに入れる
            self.window?.rootViewController = initialViewController
            // 表示
            self.window?.makeKeyAndVisible()
        } else {
            // SendVC
        }

        return true
    }
}
