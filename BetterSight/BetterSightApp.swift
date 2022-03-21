//
//  BetterSightApp.swift
//  BetterSight
//
//  Created by f on 31.01.2022.
//

import SwiftUI

@main
struct BetterSightApp: App {
    var gameLeft = CGameViewModel()
    var gameRight = CGameViewModel()
    var gameBoth = CGameViewModel()
    var settings = CSettings()
    var progress = ProgressTracker()

    
    var body: some Scene {
        WindowGroup {
            MainView(gameLeft: gameLeft, gameRight: gameRight, gameBoth: gameBoth)
                .environmentObject(settings)
                .environmentObject(progress)
        }
    }
}
