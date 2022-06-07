//
//  CSettings.swift
//  BetterSight
//
//  Created by f on 11.03.2022.
//

import Foundation

class CSettings: ObservableObject {
    
    @Published var settingComponents = SettingComponents() {
        didSet {
            if let encoded = try? JSONEncoder().encode(settingComponents) {
                UserDefaults.standard.set(encoded, forKey: "settings")
            }
        }
    }
    
    init() {
        if let savedSettings = UserDefaults.standard.data(forKey: "settings") {
            if let decodedSettings = try? JSONDecoder().decode(SettingComponents.self, from: savedSettings) {
                settingComponents = decodedSettings
                return
            }
        }
        settingComponents = SettingComponents()
    }
    
    func reset() {
        settingComponents = SettingComponents()
    }
}






