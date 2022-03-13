//
//  NewCView.swift
//  BetterSight
//
//  Created by f on 31.01.2022.
//

import SwiftUI

struct CGameView: View {
    @ObservedObject var game: CGameViewModel
    
    @State private var moveViewTo: String? = nil
    @State private var showingInfoSheet = false
    
    var body: some View {
        GeometryReader { geo in
            VStack {
        //Header
                HStack {
                    menuButton
                    Spacer()
                    moveButton
                }
                .padding()
                .frame(height: geo.size.height/10)
                .background(.gray)
                
        //LandoltC
                GeometryReader { geometry in
                    ZStack {
                        Color.clear
                        LandoltC(landoltC: game.cLetter)
                            .onAppear { game.fetchGeometry(geometry) }
                        
                    }
                }
        //ControlGround
                controlGround
                    .foregroundColor(.gray)
                    .frame(width: geo.size.width, height: geo.size.height / 4)
                    .opacity(0.4)
            }
        }
        .sheet(isPresented: $showingInfoSheet) {
            CViewInfoSheet()
        }
        .navigate(to: MainView(game: game), tag: "MainView", binding: $moveViewTo)
    }
    
    var menuButton: some View {
        Button {
            moveViewTo = "MainView"
        } label: {
            Image(systemName: "square.grid.3x3.fill")
                .resizable()
                .foregroundColor(.black)
        }
        .frame(width: 30, height: 30)
    }
    
    var infoButton: some View {
        Button {
            showingInfoSheet = true
        } label: {
            Image(systemName: "info.circle")
                .resizable()
                .foregroundColor(.gray)
                .frame(width: 30, height: 30)
        }
    }
    
    var scoreView: some View {
        HStack {
            Text(String(game.cLetter.round) + " :")
                .frame(width: 60)
            Text(String(game.cLetter.level))
                .frame(width: 60, alignment: .leading)
            Text(String(game.cLetter.wrongAnswerCount))
                .frame(width: 60, alignment: .leading)
        }
        .font(.title)
    }
    
    var moveButton: some View {
        Button {
            game.moveLetter()
//            if !game.landoltC.isMoving{ game.landoltC.offsetXY = (0, 0) }
        } label: {
            Image(systemName: "move.3d")
                .frame(width: 35, height: 35)
                .foregroundColor(game.cLetter.isMoving ? .black : .white)
                .background(.gray)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
    
    var freezeButton: some View {
        Button {
            game.freeze()
        } label: {
            Image(systemName: "snowflake")
                .frame(width: 35, height: 35)
                .foregroundColor(game.cLetter.isFrozen ? .black : .white)
                .background(.gray)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
    
    var restartButton: some View {
        Button {
            game.restart()
        } label: {
            Image(systemName: "arrow.counterclockwise")
                .frame(width: 35, height: 35)
                .foregroundColor(.white)
                .background(.gray)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
        }
    }
    
    var controlGround: some View {
        GeometryReader { geo in
            HStack {
                Button {
                    game.chooseDirection(direction: .left)
                } label: {
                    ArrowKey(direction: .left)
                }
                VStack {
                    Button {
                        game.chooseDirection(direction: .up)
                    } label: {
                        ArrowKey(direction: .up)
                    }
                    Button {
                        game.chooseDirection(direction: .down)
                    } label: {
                        ArrowKey(direction: .down)
                    }
                }
                .frame(width: geo.size.width / 1.9)
                
                Button {
                    game.chooseDirection(direction: .right)
                } label: {
                    ArrowKey(direction: .right)
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

struct LandoltC: View {
    var landoltC: CGame.CLetter
    
    var body: some View {
        Text("C")
            .font(.custom("OpticianSans-Regular", size: landoltC.size))
            .rotationEffect(Angle(degrees: landoltC.rotation))
            .offset(x: landoltC.offsetXY.0, y: landoltC.offsetXY.0)
    }

}

struct NewCView_Previews: PreviewProvider {
    static var previews: some View {
        let game = CGameViewModel()
        CGameView(game: game)
    }
}
