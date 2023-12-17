//
//  UserModel.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/11/12.
//

import FirebaseAuth
import UIKit

struct UserModel {
    func uid() -> String {
        guard let user = Auth.auth().currentUser else {
            return ""
        }
        return user.uid
    }

    func imageToData(image: UIImage) -> Data? {
        return image.pngData() ?? nil
    }
}

enum UserInfo {
    static let id = UserModel().uid()
    static var username = ""
    static var profileImage = UIImage(named: "NavigationBarDefaultProfileImage")
}
