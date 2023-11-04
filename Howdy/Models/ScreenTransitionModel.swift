//
//  ScreenTransitionModel.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/11/04.
//

import UIKit

class ScreenTransitionModel {
    func modalTransition(viewController: UIViewController, storyboardName: String, viewControllerName: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        let destinationViewController = storyboard.instantiateViewController(identifier: viewControllerName)
        destinationViewController.modalPresentationStyle = .fullScreen
        destinationViewController.modalTransitionStyle = .crossDissolve
        viewController.present(destinationViewController, animated: true)
    }

    func pushTransition(viewController: UIViewController, storyboardName: String, viewControllerName: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let destinationViewController = storyboard.instantiateViewController(identifier: viewControllerName)
        viewController.navigationController?.pushViewController(destinationViewController, animated: true)
    }
}
