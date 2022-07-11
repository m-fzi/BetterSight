//
//  ContentView.swift
//  BetterSight
//
//  Created by f on 31.01.2022.
//

import SwiftUI

struct MainView: View {
    @State private var showingCSettings = false
    @State private var showingInfoSheet = false
    @State private var moveViewTo: String?
    
    @EnvironmentObject var game: CGame
    @EnvironmentObject var settings: CSettings
    
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
                .sheet(isPresented: $showingCSettings, onDismiss: updateGameSettings) {
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
    
    // Bridge between settings and game.
    func updateGameSettings() {
        game.updateSettings(settings.settingComponents)
    }
    
    // MARK: - Subviews
    
    var betterSightScript: some View {
        Text("BetterSight .")
            .font(.custom("Chalkboard SE Bold", size: 40))
            .foregroundColor(Color(white: 0.2))
    }
    
    var versionScript: some View {
        Text("Version 3.1")
            .font(.custom("Chalkboard SE Bold", size: 15))
            .foregroundColor(Color(white: 0.5))
    }
        
    var cGameButton: some View {
        GeometryReader { geometry in
            ZStack {
                roundedRectangleBase
                HStack {
                    ZStack {
                        Color.clear
                        Button {
                            settings.settingComponents.gameIsSnellen = false
                            moveViewTo = "MoveItToCGame"
                        } label: {
                            ZStack {
                                NavigationLink(destination: CGameView(), tag: "MoveItToCGame", selection: $moveViewTo){ EmptyView() }
                                Text("C Workout")
                                    .font(.custom("OpticianSans-Regular", size: 30))
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    Divider()
                        .background(.gray)
                    gameModeButton
                        .padding(.trailing)
                        .frame(width: geometry.size.width/3)
                        .clipped()
                }
            }
        }
    }
    
    var gameModeButton: some View {
        Button {
            withAnimation {
                settings.settingComponents.cGameOnSpeech.toggle()
            }
        } label: {
            if settings.settingComponents.cGameOnSpeech {
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
    }
    
    private var rollTransition: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .offset(x: 0, y: 100),
            removal: .offset(x: 0, y: -100)
        )
    }
    
    private var snellenGameButton: some View {
        Button {
            settings.settingComponents.gameIsSnellen = true
            moveViewTo = "MoveItToSnellenGame"
        } label: {
            ZStack {
                roundedRectangleBase
                NavigationLink(destination: CGameView(), tag: "MoveItToSnellenGame", selection: $moveViewTo){ EmptyView() }
                Text("Snellen Workout")
                    .font(.custom("OpticianSans-Regular", size: 30))
                    .fontWeight(.bold)
            
            }
            .foregroundColor(.black)
            }
    }

    var cSettingsButton: some View {
        Button {
            showingCSettings = true
        } label: {
            ZStack {
                roundedRectangleBase
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
                roundedRectangleBase
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
                roundedRectangleBase
                Image(systemName: "questionmark.app")
                    .resizable()
                    .foregroundColor(.black)
                    .padding()
            }
        }.frame(width: 100, height: 100)
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
    
    // MARK: - Refactoring common views
    
    var roundedRectangleBase: some View {
        RoundedRectangle(cornerRadius: 25)
            .strokeBorder(.gray, lineWidth: 4)
            .background(RoundedRectangle(cornerRadius: 25).fill(.white))
    }
}






//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView(gameLeft: CGameViewModel(), gameRight: CGameViewModel(), gameBoth: CGameViewModel())
//    }
//}
