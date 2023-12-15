//
//  TopViewModel.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/12/15.
//

import UIKit

class TopViewModel {
    func fetchScenResult() -> String {
        return DestinationUser.destinationId
    }

    func resetDestinationInformation() {
        DestinationUser.destinationId = ""
        DestinationUser.profileImage = UIImage(named: "DefaultProfileImage")
        DestinationUser.username = ""
    }

    func registerDestinationInformation(username: String, profileImage: UIImage) {
        DestinationUser.username = username
        DestinationUser.profileImage = profileImage
    }
}
