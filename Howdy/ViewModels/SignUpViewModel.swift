//
//  SignUpViewModel.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/11/12.
//

import FirebaseAuth
import FirebaseStorage
import UIKit

class SignUpViewModel {
    let userModel = UserModel()

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

    func signup(email: String, password: String, result: @escaping (Bool, Error?) -> Void) {
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

    func createImage(uid: String, uploadImage: Data, completionHandler: @escaping (Bool) -> Void) {
        // FirebaseStorageへ保存
        let storageRef = Storage.storage().reference(forURL: "gs://howdy-fa286.appspot.com").child(uid).child("profile_image")
        storageRef.putData(uploadImage, metadata: nil) { _, error in
            if let error = error {
                print("Error:\(error)")
                return
            }
            completionHandler(true)
        }
    }
}

extension Error {
    var code: Int {
        return (self as NSError).code
    }
}
