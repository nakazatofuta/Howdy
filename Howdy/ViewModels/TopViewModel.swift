//
//  TopViewModel.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/12/15.
//

class TopViewModel {
    func fetchScenResult() -> String {
        return QRData.destinationId
    }

    func resetScanResult() {
        QRData.destinationId = ""
    }
}
