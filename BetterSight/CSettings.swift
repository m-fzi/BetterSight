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
    var cSizeAtStart: Double = 300
    var cSizeAfterEachRound: Double = 60
    var shrinkageRate: Double = 0.8
}


