//
//  CSettings.swift
//  BetterSight
//
//  Created by f on 11.03.2022.
//

import Foundation

class CSettings: ObservableObject {
    
    @Published var settingComponents = CSettingComponents() {
        didSet {
            if let encoded = try? JSONEncoder().encode(settingComponents) {
                UserDefaults.standard.set(encoded, forKey: "settings")
            }
        }
    }
    
    init() {
        if let savedSettings = UserDefaults.standard.data(forKey: "settings") {
            if let decodedSettings = try? JSONDecoder().decode(CSettingComponents.self, from: savedSettings) {
                settingComponents = decodedSettings
                return
            }
        }
        settingComponents = CSettingComponents()
    }
    
    func reset() {
        settingComponents = CSettingComponents()
    }
    
}

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
    var cSizeAfterEachRound: Double = 2
    var rawCSizeAfterEachRound: Double {
        get {
            if cSizeAfterEachRound == 1 { return 60 }
            else if cSizeAfterEachRound == 2 { return 100 }
            else if cSizeAfterEachRound == 3 { return 200 }
            else if cSizeAfterEachRound == 4 { return 300 }
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
    var activeGameTabIndex = 0 {
        didSet { oldTabIndex = oldValue}
    }
    var oldTabIndex = 0
}


