//
//  QRScannerViewModel.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/12/15.
//

class QRScannerViewModel {
    func saveScanResults(result: String) {
        DestinationUser.destinationId = result
    }
}
