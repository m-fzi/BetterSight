//
//  Settings.swift
//  BetterSight
//
//  Created by f on 31.05.2022.
//

import Foundation


struct CSettingComponents: Codable {
    var cSizeAtStart: Double = 4
    var rawCSizeAtStart: Double {
        get {
            if cSizeAtStart == 1 { return 60 }
            else if cSizeAtStart == 2 { return 100 }
            else if cSizeAtStart == 3 { return 200 }
            else if cSizeAtStart == 4 { return 300 }
            else { return 400 }
        }
    }
    var shrinkageRate: String = "Medium"
    var rawShrinkageRate: Double {
        get {
            if shrinkageRate == "Low" { return 0.9 }
            else if shrinkageRate == "Medium" { return 0.8 }
            else { return 0.7 }
        }
    }
    var soundOn: Bool = true
    var showingCheckmark = true
    var showingXmark = true
    var oldTabIndex = 0
    var activeGameTabIndex = 0 {
        didSet { oldTabIndex = oldValue}
    }
    var gameModeOnSpeech = false
    var gameIsSnellen = false
}
