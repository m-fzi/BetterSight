//
//  CGameView.swift
//  BetterSight
//
//  Created by f on 13.03.2022.
//

import SwiftUI

struct CGameView: View {
    
    @State private var moveViewTo: String? = nil
    @State private var tabIndex = 0
    
    @ObservedObject var gameLeft: CGameViewModel
    @ObservedObject var gameRight: CGameViewModel
    @ObservedObject var gameBoth: CGameViewModel
    var progress = ProgressTracker()
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                VStack {
                    ZStack {
                        HStack {
                            menuButton
                            Spacer()
                            restartButton
                        }
                        scoreView
                    }
                    
                    CGameViewTapBar(tabIndex: $tabIndex)
                }
                .padding()
                .frame(height: geo.size.height/10)
                .background(Color(white: 0.8))
                if tabIndex == 0 {
                    CGameBody(game: gameLeft)
                }
                else if tabIndex ==  1 {
                    CGameBody(game: gameRight)
                }
                else {
                    CGameBody(game: gameBoth)
                }
            }
        }
        .navigate(to: MainView(gameLeft: gameLeft, gameRight: gameRight, gameBoth: gameBoth), tag: "MainView", binding: $moveViewTo)
    }
    
    var menuButton: some View {
        Button {
            moveViewTo = "MainView"
        } label: {
            Image(systemName: "square.grid.2x2.fill")
                .resizable()
                .foregroundColor(Color(white: 0.2))
        }
        .frame(width: 30, height: 30)
    }
    var letter: CGame.CLetter { gameBoth.cLetter }
    var wrong: Int { letter.wrongAnswerCount }
    
    
    var restartButton: some View {
        Button {
            progress.addSession(gameLeft: gameLeft, gameRight: gameRight, gameBoth: gameBoth)
            gameLeft.restart()
            gameRight.restart()
            gameBoth.restart()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 90, height: 30)
                    .foregroundColor(Color(white: 0.4))
                    .shadow(color: .black, radius: 2)
                Text("Restart")
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
            }
        }
    }
    
    var scoreView: some View {
        switch tabIndex {
        case 0:
            return ScoreViewOfGame(ofWhichGamesCLetter: gameLeft.cLetter)
        case 1:
            return ScoreViewOfGame(ofWhichGamesCLetter: gameRight.cLetter)
        default:
            return ScoreViewOfGame(ofWhichGamesCLetter: gameBoth.cLetter)
        }
    }
}


struct ScoreViewOfGame: View {
    var ofWhichGamesCLetter: CGame.CLetter
    var body: some View {
        HStack(alignment: .center) {
            Text(String(ofWhichGamesCLetter.round) + " :")
                .fontWeight(.heavy)
                .frame(width: 80, alignment: .trailing)
            Text(String(ofWhichGamesCLetter.wrongAnswerCount))
                .fontWeight(.heavy)
                .frame(width: 80, alignment: .leading)
                
                
        }
        .font(.title)
        .padding(.leading)
        .foregroundColor(Color(white: 0.4))
    }
}





struct CMainView_Previews: PreviewProvider {
    static var previews: some View {
        CGameView(gameLeft: CGameViewModel(), gameRight: CGameViewModel(), gameBoth: CGameViewModel() )
    }
}
