//
//  NewCView.swift
//  BetterSight
//
//  Created by f on 31.01.2022.
//

import AVFoundation
import SwiftUI

struct CGameBody: View {
    
    @ObservedObject var game: CGame
    
    @EnvironmentObject var settings: CSettings
    
    @State private var showingInGameSettings = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.clear
                gearButton
                
                LandoltC(landoltC: game.letter)
                    .onAppear { game.fetchedGeometry = geo }
                    .confirmationDialog("InGame Settings", isPresented: $showingInGameSettings) {
                        Button(game.letter.isMoving ? "Dectivate movement" : "Activate movement") { game.activateLetterMovement() }
                        Button(game.letter.isFrozen ? "Unfreeze letter" : "Freeze letter") { game.freezeLetter() }
                    } message: {
                        Text("InGame Settings")
                    }
                    .id(game.gameID)
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
        if game.gameID == "left" {
            offsetAmount = -offsetAmount
        }
        return AnyTransition.asymmetric(
                insertion: .offset(x: offsetAmount, y: 0),
                removal: .offset(x: -offsetAmount, y: 0)
                )
    }
}
    


struct LandoltC: View {
    var landoltC: CLetter
    
    var body: some View {
        Text("C")
            .font(.custom("OpticianSans-Regular", size: landoltC.size))
            .rotationEffect(Angle(degrees: landoltC.rotation))
            .offset(x: landoltC.offsetX, y: landoltC.offsetY)
            
    }
}

//struct NewCView_Previews: PreviewProvider {
//    static var previews: some View {
//        let game = CGameViewModel()
//        CGameBody(game: game)
//    }
//}




