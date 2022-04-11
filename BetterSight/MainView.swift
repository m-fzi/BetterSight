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
    
    @ObservedObject var gameLeft: CGame
    @ObservedObject var gameRight: CGame
    @ObservedObject var gameBoth: CGame
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    Color(white: 0.85)
                        .edgesIgnoringSafeArea(.all)
                    ZStack {
                        betterSightScript
                            .position(x: geo.size.width / 2, y: geo.size.height / 7)
                        versionScript
                            .position(x: geo.size.width / 2, y: geo.size.height - 20)
                    }
                    VStack(spacing: 15) {
                        cGameButton
                            .frame(width: geo.size.width / 1.1, height: 90)
                        snellenGameButton
                            .frame(width: geo.size.width / 1.1, height: 90)
                        HStack(spacing: 20) {
                            cSettingsButton
                            speakerButton
                            questionMarkButton
                        }
                       
                    }
                    progressTrackerButton
                        .position(x: geo.size.width / 2, y: geo.size.height / 1.2)
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
    
    var betterSightScript: some View {
        Text("BetterSight .")
            .font(.custom("Chalkboard SE Bold", size: 40))
            .foregroundColor(Color(white: 0.2))
    }
    
    var versionScript: some View {
        Text("Version 3.0")
            .font(.custom("Chalkboard SE Bold", size: 15))
            .foregroundColor(Color(white: 0.5))
    }

    var cGameButton: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .strokeBorder(.gray, lineWidth: 4)
                    .background(RoundedRectangle(cornerRadius: 25).fill(.white))
                HStack {
                    ZStack {
                        Color.clear
                        NavigationLink(destination: CGameView(gameLeft: gameLeft, gameRight: gameRight, gameBoth: gameBoth)) {
                            HStack {
                                Text("C Workout")
                                    .font(.custom("OpticianSans-Regular", size: 30))
                                    .fontWeight(.bold)
                            }
                        }
                    }
                    Divider()
                        .background(.gray)
                    ZStack {
                        Color.clear
                        gameModeButton
                            .padding(.trailing)
                    } .frame(width: geometry.size.width/3)
                        .clipped()
                }
            }
            .foregroundColor(.black)
        }
    }
    
    
    var gameModeButton: some View {
        Button {
            withAnimation {
                settings.settingComponents.gameModeOnSpeech.toggle()
            }
        } label: {
            if settings.settingComponents.gameModeOnSpeech {
                VStack {
                    Text("SPEECH")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Text("MODE")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
                .transition(rollTransition)
            } else {
                VStack {
                    Text("MANUEL")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Text("MODE")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
                .transition(rollTransition)
            }
        }
        .clipped()
    }
    
    private var rollTransition: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .offset(x: 0, y: 100),
            removal: .offset(x: 0, y: -100)
        )
    }
    
    @State private var moveViewTo: String?
    private var snellenGameButton: some View {
        Button {
            settings.settingComponents.gameIsSnellen = true
            settings.settingComponents.gameModeOnSpeech = true
            moveViewTo = "MoveItToGame"
        } label: {
            ZStack {
                NavigationLink(destination: CGameView(gameLeft: gameLeft, gameRight: gameRight, gameBoth: gameBoth), tag: "MoveItToGame", selection: $moveViewTo){ EmptyView() }
                RoundedRectangle(cornerRadius: 25)
                    .strokeBorder(.gray, lineWidth: 4)
                    .background(RoundedRectangle(cornerRadius: 25).fill(.white))
                HStack {
                    Text("Snellen Workout")
                        .font(.custom("OpticianSans-Regular", size: 30))
                        .fontWeight(.bold)
                }
            }
            .foregroundColor(.black)
            }
    }
    
    var progressTrackerButton: some View {
        NavigationLink(destination: ProgressTrackerView()) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .strokeBorder(Color(white: 0.4), lineWidth: 2)
                    .foregroundColor(Color.clear)
                Text("PROGRESS TRACKER")
                    .fontWeight(.heavy)
                    .foregroundColor(Color(white: 0.4))
            } .frame(width: 230, height: 50)
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
