//
//  BetterSightApp.swift
//  BetterSight
//
//  Created by f on 31.01.2022.
//

import SwiftUI

@main
struct BetterSightApp: App {
    @StateObject var gameLeft = CGameViewModel()
    @StateObject var gameRight = CGameViewModel()
    @StateObject var gameBoth = CGameViewModel()
    @StateObject var settings = CSettings()
    @StateObject var progress = ProgressTracker()

    
    var body: some Scene {
        WindowGroup {
            MainView(gameLeft: gameLeft, gameRight: gameRight, gameBoth: gameBoth)
                .environmentObject(settings)
                .environmentObject(progress)
        }
    }
}
