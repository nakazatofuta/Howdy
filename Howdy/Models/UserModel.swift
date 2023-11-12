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
        guard let user = Auth.auth().currentUser else { return "" }
        return user.uid
    }
}
