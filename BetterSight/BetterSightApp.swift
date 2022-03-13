//
//  BetterSightApp.swift
//  BetterSight
//
//  Created by f on 31.01.2022.
//

import SwiftUI

@main
struct BetterSightApp: App {
    let game = CGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView(game: game)
        }
    }
}
