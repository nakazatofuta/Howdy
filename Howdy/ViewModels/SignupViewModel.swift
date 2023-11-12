//
//  SignupViewModel.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/11/12.
//

import FirebaseAuth
import UIKit

class SignupViewModel {
    func signup(email: String, password: String, result: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if error == nil {
                result(true)
            } else {
                print("Error:\(error!)")
                result(false)
            }
        }
    }
}
