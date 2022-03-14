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
    @ObservedObject var gameBoth: CGameViewModel
    @ObservedObject var gameRight: CGameViewModel
    
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
                    
                    CustomTopTabBar(tabIndex: $tabIndex)
                }
                .padding()
                .frame(height: geo.size.height/10)
                .background(Color(white: 0.8))
                if tabIndex == 0 {
                    CGameBody(game: gameLeft)
                }
                else if tabIndex ==  1 {
                    CGameBody(game: gameBoth)
                }
                else {
                    CGameBody(game: gameRight)
                }
            }
        }
        .navigate(to: MainView(gameLeft: gameLeft, gameBoth: gameBoth, gameRight: gameRight), tag: "MainView", binding: $moveViewTo)
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
    
    var restartButton: some View {
        Button {
            gameLeft.restart()
            gameBoth.restart()
            gameRight.restart()
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
            return ScoreViewOfGame(ofWhichGamesCLetter: gameBoth.cLetter)
        default:
            return ScoreViewOfGame(ofWhichGamesCLetter: gameRight.cLetter)
        }
    }
}

struct CustomTopTabBar: View {
    @Binding var tabIndex: Int
    var body: some View {
        HStack(spacing: 0) {
            TabBarButton(text: "Left", isSelected: .constant(tabIndex == 0))
                .onTapGesture { onButtonTapped(index: 0) }
            TabBarButton(text: "Both", isSelected: .constant(tabIndex == 1))
                .onTapGesture { onButtonTapped(index: 1) }
            TabBarButton(text: "Right", isSelected: .constant(tabIndex == 2))
                .onTapGesture { onButtonTapped(index: 2) }
        }
    }
    
    private func onButtonTapped(index: Int) {
        withAnimation { tabIndex = index }
    }
}

struct TabBarButton: View {
    let text: String
    @Binding var isSelected: Bool
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 100, height: 30)
                .foregroundColor(isSelected ? .gray : .white)
            Text(text)
                .fontWeight(.heavy)
                .foregroundColor(isSelected ? .white : .black)
                
        }
    }
}







struct CMainView_Previews: PreviewProvider {
    static var previews: some View {
        CGameView(gameLeft: CGameViewModel(), gameBoth: CGameViewModel(), gameRight: CGameViewModel())
    }
}
