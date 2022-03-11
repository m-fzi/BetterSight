//
//  CGame.swift
//  BetterSight
//
//  Created by f on 8.03.2022.
//

import Foundation
import SwiftUI

struct CGame {
    var cLetter: CLetter
    
    enum Direction: CaseIterable {
        case right, up, left, down
    }
    
    struct CLetter {
        var size: Double = 400
        var roundUpSize: Double = 60
        var rotation: Double = 0
        var direction: Direction {
            if rotation == 0 { return .right }
            else if rotation == 270 { return .up }
            else if rotation == 180 { return .left }
            else if rotation == 90 { return .down }
            else { return .right }
        }
        var offsetXY: (Double, Double) = (0, 0)
        var isFrozen = false
        var isMoving = false
        var level = 0
        var shrinkageRate: Double = 0.8
        var wrongAnswerCount = 0
        var round = 0
    }
    

    mutating func chooseDirection(_ direction: Direction, _ inGeometry: GeometryProxy) {
        if direction == cLetter.direction {
            correctAnswer(inGeometry)
        } else {
            wrongAnswer()
        }
    }
    
    private let rotationDegrees: [Double] = [0, 90, 180, 270]
    mutating private func correctAnswer(_ inGeometry: GeometryProxy) {
        cLetter.rotation = rotationDegrees.randomElement() ?? 0
        
        if !cLetter.isFrozen && cLetter.size >= 8 {
            cLetter.size = cLetter.size * cLetter.shrinkageRate
            cLetter.level += 1
        } else if cLetter.size < 8 {
            roundUp()
        }
        
        if cLetter.isMoving {
            offsetCRandomly(inGeometry)
        }
    }
    
    mutating private func wrongAnswer() {
        cLetter.wrongAnswerCount += 1
    }
    
    mutating private func roundUp() {
        cLetter.round += 1
        cLetter.level = 0
        cLetter.size = cLetter.roundUpSize
    }
    
    mutating func toggleLetterMovement() {
        if cLetter.isMoving {
            cLetter.offsetXY.0 = 0
            cLetter.offsetXY.1 = 0
        }
        cLetter.isMoving.toggle()
    }
    
    mutating private func offsetCRandomly(_ inGeometry: GeometryProxy) {
        let width = inGeometry.size.width
        let height = inGeometry.size.height
        cLetter.offsetXY.0 = Double.random(in: -(width/2 - cLetter.size/4 - 3)...(width/2 - cLetter.size/4 - 3))
        cLetter.offsetXY.1 = Double.random(in: -(height*0.3 - cLetter.size/4 - 3)...(height/4 - cLetter.size/4 - 3))
    }
    
    mutating func freezeLetter() {
        cLetter.isFrozen.toggle()
    }
    
    
}
