//
//  NewCView.swift
//  BetterSight
//
//  Created by f on 31.01.2022.
//

import AVFoundation
import SwiftUI

struct CGameBody: View {
    
    @EnvironmentObject var game: CGame
    @EnvironmentObject var settings: CSettings
    
    @State private var showingInGameSettings = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.clear
                gearButton
                
                SnellenLetter(letter: game.letter)
                    .onAppear {
                        game.fetchedGeometry = geo
                        UIApplication.shared.isIdleTimerDisabled = true
                    }
                    .confirmationDialog("InGame Settings", isPresented: $showingInGameSettings) {
                        Button(game.letter.isMoving ? "Stop Movement" : "Activate Movement") { game.activateLetterMovement() }
                        Button(game.letter.isFrozen ? "Unfreeze Letter Size" : "Freeze Letter Size") { game.freezeLetter() }
                    } message: {
                        Text("InGame Settings")
                    }
                    .id(game.activeTabIDX) // For transition.
                    .transition(rollTransition(geometry: geo))
            }
        }
    }
    
    var gearButton: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    showingInGameSettings = true
                } label: {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .foregroundColor(Color(white: 0.5))
                        .frame(width: 30, height: 30)
                    }
            }
            Spacer()
        }.padding(.trailing)
    }
    
    func rollTransition(geometry: GeometryProxy) -> AnyTransition {
        var offsetAmount = geometry.size.width
        if (game.activeTabIDX == 0) || (game.activeTabIDX == 1 && game.formerTabIDX == 2) {
            offsetAmount = -offsetAmount
        }
        return AnyTransition.asymmetric(
                insertion: .offset(x: offsetAmount, y: 0),
                removal: .offset(x: -offsetAmount, y: 0)
                )
    }
}

struct SnellenLetter: View {
    @EnvironmentObject var settings: CSettings
    
    var letter: CLetter
    
    var body: some View {
        Text(settings.settingComponents.gameIsSnellen ? letter.text : "C")
            .font(.custom("OpticianSans-Regular", size: letter.size))
            .rotationEffect(Angle(degrees: settings.settingComponents.gameIsSnellen ? 0 : letter.rotation))
            .offset(x: letter.offsetX, y: letter.offsetY)
            
    }
}




//struct NewCView_Previews: PreviewProvider {
//    static var previews: some View {
//        let game = CGameViewModel()
//        CGameBody(game: game)
//    }
//}




