//
//  NewCView.swift
//  BetterSight
//
//  Created by f on 31.01.2022.
//

import SwiftUI

struct CView: View {
    @State private var moveViewTo: String? = nil
    
    @State private var colorOfControlGround = Color.white
    @State private var level = 0
    @State private var wrongAnswerCount = 0
    @State private var roundOfWorkout = 0

    @State private var sizeOfC: Double = 300
    @State private var cDirection: Directions = .right
    @State private var rotation: Double = 0
    @State private var offsetXY: (Double, Double) = (0, 0)
    @State private var isFrozen = false
    @State private var isMoving = false
    
    @State private var showingInfoSheet = false
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                HStack {
                    menuButton
                    Spacer()
                    infoButton
                }
                .padding()
                
                HStack {
                    Spacer()
                    scoreView
                    Spacer()
                }
//                .padding(.top)
                .frame(height: geo.size.width > 500 ? 100 : 50)
                    
                ZStack {
                    Color.clear
                    LandoltC(sizeOfC: sizeOfC, rotation: rotation, offsetXY: offsetXY)
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        VStack {
                            Group {
                                restartButton
                                moveButton
                                freezeButton
                            }
                        }
                        .padding(.trailing, 3)
                    }
                    
                    // Control Ground
                    HStack {
                        Button {
                            cDirection == .left ? correctAnswer(width: geo.size.width, height: geo.size.height) : wrongAnswer()
                        } label: {
                            ZStack{
                                Rectangle()
                                arrowLeft
                            }
                        }
                        
                        VStack {
                            Button {
                                cDirection == .up ? correctAnswer(width: geo.size.width, height: geo.size.height) : wrongAnswer()
                            } label: {
                                ZStack{
                                    Rectangle()
                                    arrowUp
                                }
                            }
                            
                            Button {
                                cDirection == .down ? correctAnswer(width: geo.size.width, height: geo.size.height) : wrongAnswer()
                            } label: {
                                ZStack{
                                    Rectangle()
                                    arrowDown
                                }
                            }
                        }
                        .frame(width: geo.size.width / 1.8)
                        
                        Button {
                            cDirection == .right ? correctAnswer(width: geo.size.width, height: geo.size.height) : wrongAnswer()
                        } label: {
                            ZStack{
                                Rectangle()
                                arrowRight
                            }
                        }
                    }
                    .foregroundColor(.gray)
                    .background(colorOfControlGround)
                    .frame(width: geo.size.width, height: geo.size.height / 4)
                    .opacity(0.4)
                }
            }
        }
        .sheet(isPresented: $showingInfoSheet) {
            CViewInfoSheet()
        }
        
        .navigate(to: MainView(), tag: "MainView", binding: $moveViewTo)
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
            Text(String(roundOfWorkout) + " :")
                .frame(width: 60)
            Text(String(level))
                .frame(width: 60, alignment: .leading)
            Text(String(wrongAnswerCount))
                .frame(width: 60, alignment: .leading)
        }
        .font(.title)
    }
    
    var moveButton: some View {
        Button {
            isMoving.toggle()
            if !isMoving { offsetXY = (0, 0) }
        } label: {
            Image(systemName: "move.3d")
                .frame(width: 35, height: 35)
                .foregroundColor(isMoving ? .black : .white)
                .background(.gray)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
    
    var freezeButton: some View {
        Button {
            isFrozen.toggle()
        } label: {
            Image(systemName: "snowflake")
                .frame(width: 35, height: 35)
                .foregroundColor(isFrozen ? .black : .white)
                .background(.gray)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
    
    var restartButton: some View {
        Button {
            restart()
        } label: {
            Image(systemName: "arrow.counterclockwise")
                .frame(width: 35, height: 35)
                .foregroundColor(.white)
                .background(.gray)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
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
    
// MARK: - Indents:
        
    func correctAnswer(width: CGFloat, height: CGFloat) {
        cDirection = Directions.allCases.randomElement()!
        rotateC()
        
        if !isFrozen && sizeOfC > 9 {
            sizeOfC = sizeOfC * 0.9
            level += 1
        } else if sizeOfC < 9 {
            nextRound()
        }
        
        if isMoving {
            moveC(width: width, height: height)
        }

        changeTheColorOfControlGround(color: Color.green)
    }
    
    func wrongAnswer() {
        wrongAnswerCount += 1
        changeTheColorOfControlGround(color: Color.red)
    }
    
    func rotateC() {
        switch cDirection {
        case .right:
            rotation = 0
        case .up:
            rotation = 270
        case .left:
            rotation = 180
        case .down:
            rotation = 90
        }
    }
    
    func moveC(width: CGFloat, height: CGFloat) {
        offsetXY.0 = Double.random(in: -width/3...width/3)
        offsetXY.1 = Double.random(in: -height/4...height/6)
    }
    
    func restart() {
        sizeOfC = 300
        roundOfWorkout = 0
        level = 0
        wrongAnswerCount = 0
        offsetXY = (0, 0)
    }
    
    func nextRound() {
        sizeOfC = 55
        level = 0
        roundOfWorkout += 1
    }
    
    func changeTheColorOfControlGround(color: Color) {
        withAnimation {
            colorOfControlGround = color
        }
        // wait for ..
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
            // Back to normal with ease animation
            withAnimation {
                colorOfControlGround = Color.white
            }
        })
    }

}

struct NewCView_Previews: PreviewProvider {
    static var previews: some View {
        CView()
    }
}
