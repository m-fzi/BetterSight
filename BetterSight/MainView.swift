//
//  ContentView.swift
//  BetterSight
//
//  Created by f on 31.01.2022.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var settings = CSettings()
    @State private var showingCSettings = false
    
    var gameLeft: CGameViewModel
    var gameRight: CGameViewModel
    var gameBoth: CGameViewModel
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    Color(white: 0.85)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        cGameViewButton
                            .frame(width: geo.size.width / 1.1, height: 100)
                        progressTrackerButton
                            .frame(width: geo.size.width / 1.1, height: 100)
                        HStack {
                            cSettingsButton
                            speakerButton
                        }
                    }
                }
                .navigationBarHidden(true)
                .sheet(isPresented: $showingCSettings) {
                    CSettingsView()
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
        }
        .frame(width: 100, height: 100)
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
        }
        .frame(width: 100, height: 100)
    }
       
}





//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView(gameLeft: CGameViewModel(), gameRight: CGameViewModel(), gameBoth: CGameViewModel())
//    }
//}
