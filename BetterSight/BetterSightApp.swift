//
//  BetterSightApp.swift
//  BetterSight
//
//  Created by f on 31.01.2022.
//

import SwiftUI

@main
struct BetterSightApp: App {
    @StateObject var game = CGame()
    @StateObject var settings = CSettings()
    @StateObject var progress = ProgressTracker()
    

    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(game)
                .environmentObject(settings)
                .environmentObject(progress)
        }
    }
}


