//
//  NewCView.swift
//  BetterSight
//
//  Created by f on 31.01.2022.
//

import SwiftUI

struct CGameBody: View {
    @ObservedObject var game: CGameViewModel
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                GeometryReader { geometry in
                    ZStack {
                        Color.clear
                        LandoltC(landoltC: game.cLetter)
                            
                            .onAppear { game.fetchGeometry(geometry) }
                    }
                }
                controlGround
                    .foregroundColor(.gray)
                    .frame(width: geo.size.width, height: geo.size.height / 6)
                    .opacity(0.4)
            }
        }
    }
    
//    var infoButton: some View {
//        Button {
//            showingInfoSheet = true
//        } label: {
//            Image(systemName: "info.circle")
//                .resizable()
//                .foregroundColor(.gray)
//                .frame(width: 30, height: 30)
//        }
//    }
    
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
            .offset(x: landoltC.offsetXY.0, y: landoltC.offsetXY.1)
            
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

struct NewCView_Previews: PreviewProvider {
    static var previews: some View {
        let game = CGameViewModel()
        CGameBody(game: game)
    }
}
