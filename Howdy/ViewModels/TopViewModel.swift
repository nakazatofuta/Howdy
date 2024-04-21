//
//  TopViewModel.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/12/15.
//

import UIKit

class TopViewModel {
    let userModel = UserModel()
    
    let profileImageKey = "profileImageKey"
    
    var profileImage: UIImage {
        get {
            return UserDefaults.standard.object(forKey: profileImageKey) as! UIImage
        }
        set {
            return UserDefaults.standard.set(DestinationUserInfo.profileImage, forKey: profileImageKey)
        }
    }

    func fetchScenResult() -> String {
        return DestinationUserInfo.destinationId
    }

    func resetDestinationInformation() {
        DestinationUserInfo.destinationId = ""
        DestinationUserInfo.profileImage = UIImage(named: "DefaultProfileImage")
        DestinationUserInfo.username = ""
    }

    func registerDestinationInformation(username: String, profileImage: UIImage) {
        DestinationUserInfo.username = username
        DestinationUserInfo.profileImage = profileImage
    }
}
