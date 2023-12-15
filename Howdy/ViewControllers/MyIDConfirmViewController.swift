//
//  MyIDConfirmViewController.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/12/10.
//

import NVActivityIndicatorView
import UIKit

class MyIDConfirmViewController: UIViewController {
    @IBOutlet weak var qrCodeImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!

    private var activityIndicatorView: NVActivityIndicatorView!
    let uid = UserModel().uid()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Indicator設定
        activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50), type: NVActivityIndicatorType.lineScale, color: .accent, padding: 0)
        activityIndicatorView.center = view.center
        view.addSubview(activityIndicatorView)
        setupNavigationBar()
        self.idLabel.text = "ID: \(self.uid)"
    }

    override func viewWillAppear(_: Bool) {
        self.activityIndicatorView.startAnimating()
    }

    override func viewDidAppear(_: Bool) {
        self.qrCodeImage.image = self.generateQRCode(userData: self.uid)
        self.activityIndicatorView.stopAnimating()
    }

    private func generateQRCode(userData: String) -> UIImage? {
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else {
            return nil
        }

        let inputData = userData.data(using: .utf8)
        qrFilter.setValue(inputData, forKey: "inputMessage")
        // 誤り訂正レベルをHに指定
        qrFilter.setValue("H", forKey: "inputCorrectionLevel")

        guard let ciImage = qrFilter.outputImage else {
            return nil
        }

        // CIImageは小さい為、任意のサイズに拡大
        let sizeTransform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledCiImage = ciImage.transformed(by: sizeTransform)

        // CIImageだとSwiftUIのImageでは表示されない為、CGImageに変換
        let context = CIContext()
        guard let cgImage = context.createCGImage(scaledCiImage, from: scaledCiImage.extent) else {
            return nil
        }

        return UIImage(cgImage: cgImage).composited(withSmallCenterImage: UIImage(named: "AppIcon")!)
    }

    @IBAction func didTapCopyButton(_: Any) {
        UIPasteboard.general.string = self.uid
    }
}

extension UIImage {
    // UIImageの中心に小さいUIImageを配置して合成する
    func composited(withSmallCenterImage centerImage: UIImage) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { context in

            let imageWidth = context.format.bounds.width
            let imageHeight = context.format.bounds.height
            let centerImageLength = imageWidth < imageHeight ? imageWidth / 5 : imageHeight / 5
            let centerImageRadius = centerImageLength * 0.2

            // 背面に設置する親画像を描画
            draw(in: CGRect(origin: CGPoint(x: 0, y: 0),
                            size: context.format.bounds.size))

            // 中心に設置する画像のrectを設定
            let centerImageRect = CGRect(x: (imageWidth - centerImageLength) / 2,
                                         y: (imageHeight - centerImageLength) / 2,
                                         width: centerImageLength,
                                         height: centerImageLength)

            // 画像に角丸をつける為のパスを作成
            let roundedRectPath = UIBezierPath(roundedRect: centerImageRect,
                                               cornerRadius: centerImageRadius)
            // クリッピングパスを追加
            roundedRectPath.addClip()

            // 中心に設置する画像を描画
            centerImage.draw(in: centerImageRect)
        }
    }
}
