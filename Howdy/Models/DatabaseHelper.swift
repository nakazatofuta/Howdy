//
//  DatabaseHelper.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/12/10.
//

import FirebaseFirestoreInternal
import FirebaseStorage
import FirebaseStorageUI
import Foundation

class DatabaseHelper {
    let uid = UserModel().uid()
    let database = Firestore.firestore()
    let storage = Storage.storage().reference(forURL: "gs://howdy-fa286.appspot.com")

    func getUserInfo(userId: String, completionHandler: @escaping (String, Bool) -> Void) {
        database.collection("users").document(userId).getDocument(completion: { querySnapshot, error in
            if error == nil {
                let data = querySnapshot?.data()
                guard let safeData = data else {
                    completionHandler("", true)
                    return
                }
                guard let username = safeData["username"] as? String else {
                    completionHandler("", false)
                    return
                }
                completionHandler(username, true)
            } else {
                completionHandler("", false)
            }
        })
    }

    func getProfileImage(userId: String, imageView: UIImageView) {
        let imageRef = storage.child(userId).child("profile_image").child("\(userId).jpeg")
        // 画像を読み込み、imageViewに表示
        imageView.sd_setImage(with: imageRef)
    }
}
