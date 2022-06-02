//
//  CGameView.swift
//  BetterSight
//
//  Created by f on 13.03.2022.
//

import AVFoundation
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
    
    @StateObject var speechRecognizer = SpeechRecognizer()
    
//    var successPlayer = SoundPlayer(of: "success", ext: "mp3")
//    var failurePlayer: SoundPlayer = { SoundPlayer(of: "failure", ext: "m4a") }()
//    var dingPlayer = SoundPlayer(of: "ding", ext: "mp3")
    
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
                if !settings.settingComponents.gameModeOnSpeech {
                    controlGround
                        .foregroundColor(.gray)
                        .frame(width: geo.size.width, height: geo.size.height / 5)
                        .opacity(0.4)
                } else {
                    speechGround
                        .frame(width: geo.size.width, height: geo.size.height / 6)
                        .background(Color(white: 0.9))
                }
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
            if listeningIsActive { stopListening() }
            self.presentationMode.wrappedValue.dismiss()
            settings.settingComponents.gameIsSnellen = false
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
                playSound(name: "ding", ext: "mp3")
            }
            progress.addSession(gameLeft: gameLeft, gameRight: gameRight, gameBoth: gameBoth)
            gameLeft.restart()
            gameRight.restart()
            gameBoth.restart()
            if listeningIsActive { stopListening() }
            
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
    
    private func stopListening() {
        speechRecognizer.stopTranscribing()
        listeningIsActive = false
        speechRecognizer.listeningIsStopped = true
    }
    
    private func startListening() {
        speechRecognizer.transcribe()
        listeningIsActive = true
        speechRecognizer.listeningIsStopped = false
    }
    
    @State private var listeningIsActive: Bool = false
    var speechGround: some View {
        VStack {
            Button {
                if !listeningIsActive {
                    startListening()
                } else {
                    stopListening()
                }
            } label: {
                if !listeningIsActive {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(white: 0.6))
                            .frame(height: 50)
                        Text("Tap To Start!")
                            .fontWeight(.heavy)
                            .font(.headline)
                            .foregroundColor(.white)
                        }
                        .padding(.horizontal)
                        .padding(.top)
                    
                } else {
                    HStack {
                        Text("Your answer: ")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .frame(width: 150, alignment: .trailing)
                        Text(settings.settingComponents.gameIsSnellen ? " \(speechRecognizer.letterTranscript) " : " \(speechRecognizer.transcript) ")
                            .fontWeight(.heavy)
                            .font(.title)
                            .foregroundColor(.black)
                            .frame(width: 150, alignment: .leading)
                    }
                    .padding(.horizontal)
                    .padding(.top)
                }
            }
            .onReceive(settings.settingComponents.gameIsSnellen ? speechRecognizer.$letterTranscript : speechRecognizer.$transcript) { transcript in
                calculateSpeechAnswer(transcript: transcript)
            }
            
            Spacer()
            if !settings.settingComponents.gameIsSnellen {
                Text("(Say: Right, Left, Up or Down)")
                    .foregroundColor(.secondary)
                    .fontWeight(.heavy)
                    .padding(.bottom)
            } else {
                Text("(Say a word that starts with the letter you see.)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .fontWeight(.heavy)
                    .padding(.bottom)
            }
        }
       
    }
        
    
    private func calculateSpeechAnswer(transcript: String) {
        if !settings.settingComponents.gameIsSnellen {
            if transcript == "UP" {
                game.chooseDirection(direction: .up)
                showResponse()
            } else if transcript == "DOWN" {
                game.chooseDirection(direction: .down)
                showResponse()
            } else if transcript == "LEFT" {
                game.chooseDirection(direction: .left)
                showResponse()
            } else if transcript == "RIGHT" {
                game.chooseDirection(direction: .right)
                showResponse()
            }
        } else {
            if !transcript.isEmpty {
                game.chooseSnellenLetter(letterText: transcript)
                showResponse()
            }
        }
    }
    
    private func calculateSpeechAnswerForSnellen(letterTranscript: String) {
        
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
    
    private func showResponse() {
        if game.correctResponseTrigger  {
            if settings.settingComponents.soundOn {
                playSound(name: "success", ext: "mp3")
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
                playSound(name: "failure", ext: "m4a")
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








//struct CMainView_Previews: PreviewProvider {
//    static var previews: some View {
//        CGameView(gameLeft: CGameViewModel(), gameRight: CGameViewModel(), gameBoth: CGameViewModel() )
//    }
//}



