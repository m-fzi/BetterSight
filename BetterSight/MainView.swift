//
//  ContentView.swift
//  BetterSight
//
//  Created by f on 31.01.2022.
//

import SwiftUI

struct MainView: View {
    @State private var moveViewTo: String? = nil
    @State private var showingCSettings = false
    
    var gameLeft: CGameViewModel
    var gameRight: CGameViewModel
    var gameBoth: CGameViewModel
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(white: 0.85)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    cGameViewButton
                        .frame(width: geo.size.width / 1.1, height: 100)
                    progressTrackerButton
                        .frame(width: geo.size.width / 1.1, height: 100)
                    cSettingsButton
                }
                
            }
            .navigate(to: CGameView(gameLeft: gameLeft, gameRight: gameRight, gameBoth: gameBoth), tag: "CGameView", binding: $moveViewTo)
            .navigate(to: ProgressTrackerView(gameLeft: gameLeft,  gameRight: gameRight, gameBoth: gameBoth), tag: "ProgressTrackerView", binding: $moveViewTo)
            .sheet(isPresented: $showingCSettings) {
                CSettingsView()
            }
        }
    }
    
    var cGameViewButton: some View {
        Button {
            moveViewTo = "CGameView"
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .strokeBorder(.gray, lineWidth: 4)
                    .background(RoundedRectangle(cornerRadius: 25).fill(.white))
                HStack {
                    Text("C")
                        .font(.custom("OpticianSans-Regular", size: 100))
                    Text("Workout")
                        .font(.title3)
                        .fontWeight(.bold)
                }
            }
            .foregroundColor(.black)
        }
    }
    
    var progressTrackerButton: some View {
        Button {
            moveViewTo = "ProgressTrackerView"
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .strokeBorder(.gray, lineWidth: 4)
                    .background(RoundedRectangle(cornerRadius: 25).fill(.white))
                HStack {
                    Text("Progress Tracker")
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
            .foregroundColor(.black)
        }
    }

    var cSettingsButton: some View {
        Button {
            showingCSettings = true
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .strokeBorder(.gray, lineWidth: 4)
                    .background(RoundedRectangle(cornerRadius: 25).fill(.white))
                Image(systemName: "gearshape")
                    .resizable()
                    .foregroundColor(.black)
                    .padding()
            }
        }
        .frame(width: 100, height: 100)
    }
       
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(gameLeft: CGameViewModel(), gameRight: CGameViewModel(), gameBoth: CGameViewModel())
    }
}
