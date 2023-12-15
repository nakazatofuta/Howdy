//
//  QRScannerViewController.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/12/15.
//

import AVFoundation
import UIKit

class QRScannerViewController: UIViewController {
    // カメラ用のAVsessionインスタンス
    private let AVsession = AVCaptureSession()
    // カメラ画像レイヤー
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    // 背面カメラ
    let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back)

    override func viewDidLoad() {
        super.viewDidLoad()
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            break
        case .notDetermined:
            // 権限リクエスト
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if !granted {}
            }
        default:
            break
        }
        self.cameraInit()
    }

    func cameraInit() {
        // カメラデバイスの取得
        let devices = self.discoverySession.devices

        // 背面のカメラ情報を取得
        if let backCamera = devices.first {
            do {
                // カメラ入力をinputとして取得
                let input = try AVCaptureDeviceInput(device: backCamera)

                // Metadata情報（今回はQRコード）を取得する準備
                // AVssessionにinputを追加:既に追加されている場合を考慮してemptyチェックをする
                if self.AVsession.inputs.isEmpty {
                    self.AVsession.addInput(input)
                    // MetadataOutput型の出力用の箱を用意
                    let captureMetadataOutput = AVCaptureMetadataOutput()
                    // captureMetadataOutputに先ほど入力したinputのmetadataoutputを入れる
                    self.AVsession.addOutput(captureMetadataOutput)
                    // MetadataObjectsのdelegateに自己(self)をセット
                    captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                    // Metadataの出力タイプをqrにセット
                    captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]

                    // カメラ画像表示viewの準備とカメラの開始
                    // カメラ画像を表示するAVCaptureVideoPreviewLayer型のオブジェクトをsessionをAVsessionで初期化でプレビューレイヤを初期化
                    self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.AVsession)
                    // カメラ画像を表示するvideoPreviewLayerの大きさをview（superview）の大きさに設定
                    guard let safeNavigationController = self.navigationController else {
                        return
                    }
                    self.videoPreviewLayer?.frame = view.layer.bounds.inset(by: UIEdgeInsets(top: safeNavigationController.navigationBar.frame.height, left: 0, bottom: 0, right: 0))
                    // カメラ画像を表示するvideoPreviewLayerをビューに追加
                    guard let safeVideoPreviewLayer = self.videoPreviewLayer else {
                        return
                    }
                    view.layer.addSublayer(safeVideoPreviewLayer)
                }
                // セッションの開始(今回はカメラの開始)
                DispatchQueue.global(qos: .background).async {
                    self.AVsession.startRunning()
                }
            } catch {
                print("Error occured while creating video device input: \(error)")
            }
        }
    }
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate

extension QRScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from _: AVCaptureConnection) {
        // カメラ画像にオブジェクトがあるか確認
        if metadataObjects.count == 0 {
            return
        }
        // オブジェクトの中身を確認
        guard let safeMetaData = metadataObjects as? [AVMetadataMachineReadableCodeObject] else {
            return
        }
        for metadata in safeMetaData {
            guard let value = metadata.stringValue else {
                return
            }
            // 停止
            self.AVsession.stopRunning()
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
