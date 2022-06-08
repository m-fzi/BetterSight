//
//  Settings.swift
//  BetterSight
//
//  Created by f on 31.05.2022.
//

import Foundation

struct SettingComponents: Codable {
    var rawCSizeAtStart: Double = LetterConstants.rawSize
    var rawShrinkageRate: String = LetterConstants.rawShrinkageRate
    var soundOn: Bool = true
    var showingCheckmark = true
    var showingXmark = true
    var cGameOnSpeech = false
    var gameIsSnellen = false
    var gameMode = "Basic" // false-Basic | true-Structured
    
    var cSizeAtStart: Double {
        get {
            switch rawCSizeAtStart {
            case 1: return 60
            case 2:  return 100
            case 3:  return 200
            case 4:  return 300
            case 5: return 400
            default: return 300
            }
        }
    }
    var shrinkageRate: Double {
        get {
            switch rawShrinkageRate {
            case "Low": return 0.9
            case "Medium": return 0.8
            case "High": return 0.7
            default: return 0.8
            }
        }
    }
    var gameModeIsStructured: Bool {
        get {
            switch gameMode {
            case "Basic": return false
            case "Structured": return true
            default: return true
            }
        }
    }
}
