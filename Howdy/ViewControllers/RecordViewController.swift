//
//  RecordViewController.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/10/22.
//

import AVFoundation
import UIKit

class RecordViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    @IBOutlet private var destinationProfileImage: UIImageView!
    @IBOutlet private var destinationUsernameLabel: UILabel!
    @IBOutlet private var recordingProgressBar: UIProgressView!
    @IBOutlet private var recordingStatusButton: UIButton!

    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var isRecording = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupImageView()
        destinationProfileImage.image = DestinationUserInfo.profileImage
        destinationUsernameLabel.text = DestinationUserInfo.username
        updateProgress(0.0)
    }

    func setupImageView() {
        destinationProfileImage.clipsToBounds = true
        destinationProfileImage.layer.cornerRadius = destinationProfileImage.frame.width / 2
    }

    func updateProgress(_ progress: Float) {
        recordingProgressBar.progress = progress
        recordingProgressBar.setProgress(progress, animated: true)
    }

    // swiftlint:disable force_try
    @IBAction func didTapRecordingStatusButton(_: Any) {
        var progress: Float = 0.0
        updateProgress(progress)
        if !isRecording {
            DispatchQueue.global().async {
                for _ in 1 ... 7 {
                    usleep(1000000)
                    progress += 1 / 7
                    DispatchQueue.main.async {
                        self.updateProgress(progress)
                    }
                }
            }
            let session = AVAudioSession.sharedInstance()
            try! session.setCategory(.playAndRecord)
            try! session.overrideOutputAudioPort(.speaker)
            try! session.setActive(true)
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            audioRecorder = try! AVAudioRecorder(url: getURL(), settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            recordingStatusButton.setImage(UIImage(named: "MicNotActive"), for: .normal)
        } else {
            audioRecorder.stop()
            recordingStatusButton.setImage(UIImage(named: "ReRec"), for: .normal)
        }
        isRecording = !isRecording
    }

    @IBAction func didTapSendButton(_: Any) {
        audioPlayer = try! AVAudioPlayer(contentsOf: getURL())
        audioPlayer.delegate = self
        audioPlayer.play()
//        navigationController?.popToRootViewController(animated: true)
    }

    // swiftlint:enable force_try

    private func getURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDirect = paths[0]
        let url = docsDirect.appendingPathComponent("sample.m4a")
        return url
    }
}
