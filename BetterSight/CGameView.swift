//
//  CGameView.swift
//  BetterSight
//
//  Created by f on 13.03.2022.
//

import SwiftUI

struct CGameView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var gameLeft: CGame
    @ObservedObject var gameRight: CGame
    @ObservedObject var gameBoth: CGame
    @EnvironmentObject var progress: ProgressTracker
    @EnvironmentObject var settings: CSettings
    
    @State private var checkMarkSize = 300.0
    @State private var xMarkSize = 300.0
    @State private var checkMarkOpacity = 0.0
    @State private var xMarkOpacity = 0.0
    
//    @StateObject var speechRecognizer = SpeechRecognizer()
//    @State private var isRecording = false
    
    private var tabIndex: Int { settings.settingComponents.activeGameTabIndex }
    private var game: CGame {
        switch tabIndex {
        case 0: return gameLeft
        case 1: return gameRight
        default: return gameBoth
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                gameHeader
                    .padding()
                    .frame(height: geo.size.height/10)
                    .background(Color(white: 0.8))
                    

                ZStack {
                    CGameBody(game: game)
                    xMark
                    checkMark
                }
                
                controlGround
                    .foregroundColor(.gray)
                    .frame(width: geo.size.width, height: geo.size.height / 5)
                    .opacity(0.4)
            }
        }
        .navigationBarHidden(true)
    }
    
    var gameHeader: some View {
        VStack {
            ZStack {
                HStack {
                    menuButton
                    Spacer()
                    restartButton
                }
                scoreView
            }
            
            CGameViewTapBar(tabIndex: $settings.settingComponents.activeGameTabIndex)
        }
    }
    
    var menuButton: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "square.grid.2x2.fill")
                .resizable()
                .foregroundColor(Color(white: 0.2))
        }
        .frame(width: 30, height: 30)
    }
    
    var restartButton: some View {
        Button {
            if settings.settingComponents.soundOn {
                playSound(sound: "bling2", type: "mp3")
            }
            progress.addSession(gameLeft: gameLeft, gameRight: gameRight, gameBoth: gameBoth)
            gameLeft.restart()
            gameRight.restart()
            gameBoth.restart()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color(white: 0.4))
                    .shadow(color: .black, radius: 2)
                Text("Save|Redo")
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
            }.frame(width: 100, height: 30)
        }
    }
    
    var scoreView: some View {
        HStack(alignment: .center) {
            Text(String(game.letter.round) + " :")
                .fontWeight(.heavy)
                .frame(width: 80, alignment: .trailing)
            Text(String(game.letter.wrongAnswerCount))
                .fontWeight(.heavy)
                .frame(width: 80, alignment: .leading)
        }
        .font(.title)
        .padding(.leading)
        .foregroundColor(Color(white: 0.4))
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
            .foregroundColor(Color(white: 0.9))
            .background(.green)
            .clipShape(RoundedRectangle(cornerRadius: 50))
            .frame(width: checkMarkSize, height: checkMarkSize)
            .opacity(checkMarkOpacity)
    }
    
    var xMark: some View {
        Image(systemName: "xmark.square.fill")
            .resizable()
            .foregroundColor(Color(white: 0.9))
            .background(.red)
            .clipShape(RoundedRectangle(cornerRadius: 50))
            .frame(width: xMarkSize, height: xMarkSize)
            .opacity(xMarkOpacity)
    }
    
    func showResponse() {
        
        if game.correctResponseTrigger  {
            if settings.settingComponents.soundOn {
                playSound(sound: "bling3", type: "mp3")
            }
            
            if settings.settingComponents.showingCheckmark {
                checkMarkOpacity = 1
                withAnimation(Animation.linear(duration: 0.01).delay(1)) {
                    checkMarkOpacity = 0
                }
            }
            
            if game.letter.isMoving {
                game.offsetCRandomly()
            }
            
        } else if game.wrongResponseTrigger {
            if settings.settingComponents.soundOn {
                playSound(sound: "wrong3", type: "m4a")
            }
            if settings.settingComponents.showingXmark {
                xMarkOpacity = 1
                withAnimation(Animation.linear(duration: 0.01).delay(1)) {
                    xMarkOpacity = 0
                }
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


//                .onAppear {
//                    speechRecognizer.reset()
//                    speechRecognizer.transcribe()
//                    isRecording = true
//                }
//                .onDisappear {
//                    speechRecognizer.stopTranscribing()
//                    isRecording = false
//                }



//struct CMainView_Previews: PreviewProvider {
//    static var previews: some View {
//        CGameView(gameLeft: CGameViewModel(), gameRight: CGameViewModel(), gameBoth: CGameViewModel() )
//    }
//}
