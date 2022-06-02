//
//  SoundPlayer.swift
//  BetterSight
//
//  Created by f on 20.03.2022.
//

import AVFoundation
import Foundation

// TODO: - Fix this.

var audioPlayer: AVAudioPlayer?

func playSound(name: String, ext: String) {
    if let path = Bundle.main.path(forResource: name, ofType: ext) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("ERROR")
        }
    }
}
