//
//  SigninViewModel.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/11/12.
//

import FirebaseAuth
import UIKit

class SigninViewModel {
    func signup(email: String, password: String, result: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            guard let strongSelf = self else {
                return
            }
            if error == nil {
                result(true)
            } else {
                guard let error = error else {
                    return
                }
                print("Error:\(error)")
                result(false)
            }
        }
    }
}
