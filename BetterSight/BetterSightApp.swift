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
    var gameBoth = CGameViewModel()
    var gameRight = CGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView(gameLeft: gameLeft, gameBoth: gameBoth, gameRight: gameRight)
        }
    }
}
