//
//  ContentView.swift
//  BetterSight
//
//  Created by f on 31.01.2022.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var settings: CSettings
    @State private var showingCSettings = false
    @State private var showingInfoSheet = false
    
    @ObservedObject var gameLeft: CGameViewModel
    @ObservedObject var gameRight: CGameViewModel
    @ObservedObject var gameBoth: CGameViewModel
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    Color(white: 0.85)
                        .edgesIgnoringSafeArea(.all)
                    ZStack {
                        Text("BetterSight .")
                            .position(x: geo.size.width / 2, y: geo.size.height / 7)
                            .font(.custom("Chalkboard SE Bold", size: 40))
                            .foregroundColor(Color(white: 0.2))
                        
                        Text("Version 2.0")
                            .position(x: geo.size.width / 2, y: geo.size.height - 20)
                            .font(.custom("Chalkboard SE Bold", size: 15))
                            .foregroundColor(Color(white: 0.5))
                    }
                    VStack(spacing: 20) {
                        cGameViewButton
                            .frame(width: geo.size.width / 1.1, height: 100)
                        progressTrackerButton
                            .frame(width: geo.size.width / 1.1, height: 100)
                        HStack(spacing: 20) {
                            cSettingsButton
                            speakerButton
                            questionMarkButton
                        }
                    }
                }
                .navigationBarHidden(true)
                .sheet(isPresented: $showingCSettings) {
                    CSettingsView()
                }
                .sheet(isPresented: $showingInfoSheet) {
                    InfoSheet()
                }
            }
        }
        .navigationViewStyle(.stack)
        .statusBar(hidden: false)
    }
    
    var cGameViewButton: some View {
        NavigationLink(destination: CGameView(gameLeft: gameLeft, gameRight: gameRight, gameBoth: gameBoth)) {
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
        NavigationLink(destination: ProgressTrackerView()) {
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
        }.frame(width: 100, height: 100)
    }
    
    var speakerButton: some View {
        Button {
            withAnimation {
                settings.settingComponents.soundOn.toggle()
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .strokeBorder(.gray, lineWidth: 4)
                    .background(RoundedRectangle(cornerRadius: 25).fill(.white))
                if settings.settingComponents.soundOn {
                    Image(systemName: "speaker.wave.2")
                        .resizable()
                        .foregroundColor(.black)
                        .padding()
                } else {
                    Image(systemName: "speaker.slash")
                        .resizable()
                        .foregroundColor(.black)
                        .padding()
                }
            }
        }.frame(width: 100, height: 100)
    }
    
    var questionMarkButton: some View {
        Button {
            showingInfoSheet = true
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .strokeBorder(.gray, lineWidth: 4)
                    .background(RoundedRectangle(cornerRadius: 25).fill(.white))
                Image(systemName: "questionmark.app")
                    .resizable()
                    .foregroundColor(.black)
                    .padding()
            }
        }.frame(width: 100, height: 100)
    }
       
}





//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView(gameLeft: CGameViewModel(), gameRight: CGameViewModel(), gameBoth: CGameViewModel())
//    }
//}
