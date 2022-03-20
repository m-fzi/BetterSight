//
//  NewCView.swift
//  BetterSight
//
//  Created by f on 31.01.2022.
//

import AVFoundation
import SwiftUI

struct CGameBody: View {
    
    @ObservedObject var game: CGameViewModel
    @State private var showingInGameSettings = false
    @State private var checkMarkSize = 0.0
    @State private var xMarkSize = 0.0
    @State private var responseMarkOpacity = 1.0
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
        // Gear Button
                VStack {
                    HStack {
                        Spacer()
                        gearButton
                    }
                    Spacer()
                }
                .padding(.trailing)
        // GameBody
                VStack {
                    GeometryReader { geometry in
                        ZStack {
                            Color.clear
                            LandoltC(landoltC: game.cLetter)
                                .onAppear { game.fetchGeometry(geometry) }
                            checkMark
                            xMark
                        }
                    }
                    controlGround
                        .foregroundColor(.gray)
                        .frame(width: geo.size.width, height: geo.size.height / 6)
                        .opacity(0.4)
                }
            }
        }
        .confirmationDialog("InGame Settings", isPresented: $showingInGameSettings) {
            Button(game.cLetter.isMoving ? "Dectivate movement" : "Activate movement") { game.moveLetter() }
            Button(game.cLetter.isFrozen ? "Unfreeze letter" : "Freeze letter") { game.freeze() }
        } message: {
            Text("InGame Settings")
        }
    }
    
    var gearButton: some View {
        Button {
            showingInGameSettings = true
        } label: {
            Image(systemName: "gearshape.fill")
                .resizable()
                .foregroundColor(Color(white: 0.5))
                .frame(width: 30, height: 30)
        }
    }
    
    var controlGround: some View {
        GeometryReader { geo in
            HStack {
                Button {
                    game.chooseDirection(direction: .left)
                    showResponse()
                } label: {
                    ArrowKey(direction: .left)
                }
                VStack {
                    Button {
                        game.chooseDirection(direction: .up)
                        showResponse()
                    } label: {
                        ArrowKey(direction: .up)
                    }
                    Button {
                        game.chooseDirection(direction: .down)
                        showResponse()
                    } label: {
                        ArrowKey(direction: .down)
                    }
                }
                .frame(width: geo.size.width / 1.9)
                
                Button {
                    game.chooseDirection(direction: .right)
                    showResponse()
                } label: {
                    ArrowKey(direction: .right)
                }
            
            }
        }
    }
    
    var checkMark: some View {
        Image(systemName: "checkmark.square.fill")
            .resizable()
            .frame(width: checkMarkSize, height: checkMarkSize)
            .foregroundColor(.green)
            .background(.white)
            .opacity(responseMarkOpacity)
    }
    
    var xMark: some View {
        Image(systemName: "xmark.square.fill")
            .resizable()
            .frame(width: xMarkSize, height: xMarkSize)
            .foregroundColor(.red)
            .background(.white)
            .opacity(responseMarkOpacity)
    }
    
    func showResponse() {
        responseMarkOpacity = 1
        if game.checkMarkTrigger {
            if CSettings().settingComponents.soundOn {
                playSound(sound: "beep1", type: "mp3")
            }
            
            withAnimation(Animation.linear(duration: 0)) {
                checkMarkSize = 300
            }
            withAnimation(Animation.linear(duration: 0.8).delay(0.8)) {
                responseMarkOpacity = 0
            }
            withAnimation(Animation.linear(duration: 0.001).delay(1.6)) {
                checkMarkSize = 0
            }
        } else if game.xMarkTrigger {
            if CSettings().settingComponents.soundOn {
                playSound(sound: "error1", type: "mp3")
            }
            
            withAnimation(Animation.linear(duration: 0)) {
                xMarkSize = 300
            }
            withAnimation(Animation.linear(duration: 0.8).delay(0.8)) {
                responseMarkOpacity = 0
            }
            withAnimation(Animation.linear(duration: 0.001).delay(1.6)) {
                xMarkSize = 0
            }
        }
        
    }
    
    
}

struct ArrowKey: View {
    enum Direction {
        case right, up, left, down
    }
    var direction: Direction
    
    var body: some View {
        ZStack{
            Rectangle()
            if direction == .right {
                arrowRight
            } else if direction == .up {
                arrowUp
            } else if direction == .left {
                arrowLeft
            } else if direction == .down {
                arrowDown
            }
        }
    }
    
    var arrowRight: some View {
        Image(systemName: "arrowtriangle.right")
            .resizable()
            .frame(width: 30, height: 30)
    }
    
    var arrowUp: some View {
        Image(systemName: "arrowtriangle.up")
            .resizable()
            .frame(width: 30, height: 30)
    }
    
    var arrowLeft: some View {
        Image(systemName: "arrowtriangle.left")
            .resizable()
            .frame(width: 30, height: 30)
    }
    
    var arrowDown: some View {
        Image(systemName: "arrowtriangle.down")
            .resizable()
            .frame(width: 30, height: 30)
    }
}

struct LandoltC: View {
    var landoltC: CGame.CLetter
    
    var body: some View {
        Text("C")
            .font(.custom("OpticianSans-Regular", size: landoltC.size))
            .rotationEffect(Angle(degrees: landoltC.rotation))
            .offset(x: landoltC.offsetXY.0, y: landoltC.offsetXY.1)
            
    }
}

struct NewCView_Previews: PreviewProvider {
    static var previews: some View {
        let game = CGameViewModel()
        CGameBody(game: game)
    }
}




