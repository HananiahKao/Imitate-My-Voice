//
//  AudioManager.swift
//  Imitate My Voice
//
//  Created by Hananiah on 2025/2/28.
//
import SwiftUI
import AVFoundation

 class AudioManager: NSObject, ObservableObject {
    private var recorder: AVAudioRecorder?
    private var player: AVAudioPlayer?
    private var audioSession: AVAudioSession?
    @Published var audioFileURL: URL?

    // Publisher to notify when recording finishes
    @Published var didFinishRecording = false

    override init() {
        super.init()
        setupAudioSession()
    }

    // Setup the audio session
    private func setupAudioSession() {
        audioSession = AVAudioSession.sharedInstance()
        try? audioSession?.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker, .mixWithOthers])
        try? audioSession?.setActive(true)
    }

    // Start recording
    func startRecording() {
        let fileName = "audioRecording.m4a"
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            recorder = try AVAudioRecorder(url: path, settings: settings)
            recorder?.record()
            audioFileURL = path
        } catch {
            print("Failed to start recording: \(error)")
        }
    }

    // Stop recording
    func stopRecording() {
        recorder?.stop()
        self.didFinishRecording = true
    }

    // Play the recorded audio
     func playRecordedAudio() {
         guard let url = audioFileURL else { return }
         
         do {
             player = try AVAudioPlayer(contentsOf: url)
             player?.prepareToPlay()
             player?.play()
         } catch {
             print("Failed to play recorded audio: \(error)")
         }
     }
}
