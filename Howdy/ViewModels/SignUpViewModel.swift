//
//  SignUpViewModel.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/11/12.
//

import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreInternal
import FirebaseStorage
import UIKit

class SignUpViewModel {
    let userModel = UserModel()
    let database = DatabaseHelper().database
    let storage = DatabaseHelper().storage

    var mailAddress: String = ""
    var username: String = ""
    var password: String = ""

    func usernameValidation(username: String, completionHandler: @escaping (String?, Error?) -> Void) {
        let apiUrl = "https://www.purgomalum.com/service/json?text=\(username)"
        if let url = URL(string: apiUrl) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, error in
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(UsernameData.self, from: safeData)
                        completionHandler(decodedData.result, nil)
                    } catch {
                        print("Error:\(error)")
                        completionHandler(nil, error)
                    }
                }
                guard let error = error else {
                    return
                }
                print("Error:\(error)")
                completionHandler(nil, error)
            }
            task.resume()
        }
    }

    func signUp(email: String, password: String, result: @escaping (Bool, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { success, error in
            if success != nil {
                result(true, nil)
            } else {
                guard let error = error else {
                    return
                }
                print("Error:\(error.code)")
                result(false, error)
            }
        }
    }

    func registerUserInfo(uid: String, username: String, uploadImage: Data, completionHandler: @escaping (Bool) -> Void) {
        database.collection("users").document(uid).setData(["username": username]) { error in
            if error != nil {
                completionHandler(false)
            }
        }
        // FirebaseStorageへ保存
        storage.child(uid).child("profile_image").child("\(uid).jpeg").putData(uploadImage, metadata: nil) { _, error in
            if error != nil {
                completionHandler(false)
            }
        }
        completionHandler(true)
    }
}

extension Error {
    var code: Int {
        return (self as NSError).code
    }
}
