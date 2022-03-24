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
    var fetchedGeometry: GeometryProxy?
    var correctResponseTrigger  = false
    var wrongResponseTrigger = false
    
    enum Direction: CaseIterable {
        case right, up, left, down
    }
    
    struct CLetter {
        var size: Double = CSettings().settingComponents.rawCSizeAtStart
        var roundUpSize: Double = CSettings().settingComponents.rawCSizeAfterEachRound
        var shrinkageRate: Double = CSettings().settingComponents.rawShrinkageRate
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
        var wrongAnswerCount = 0
        var round = 0
    }
    

    mutating func chooseDirection(_ direction: Direction) {
        resetTriggers()
        if direction == cLetter.direction {
            correctAnswer()
        } else {
            wrongAnswer()
        }
    }
    
    private let rotationDegrees: [Double] = [0, 90, 180, 270]
    mutating private func correctAnswer() {
        cLetter.rotation = rotationDegrees.randomElement() ?? 0
        
        if !cLetter.isFrozen && cLetter.size >= 8 {
            cLetter.size = cLetter.size * cLetter.shrinkageRate
            cLetter.level += 1
        } else if cLetter.size < 8 {
            roundUp()
        }
        
        if cLetter.isMoving {
            offsetCRandomly()
        }
        correctResponseTrigger = true
    }
    
    mutating private func wrongAnswer() {
        cLetter.wrongAnswerCount += 1
        wrongResponseTrigger = true
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
    
    mutating private func offsetCRandomly() {
        let width = fetchedGeometry?.size.width ?? 100
        let height = fetchedGeometry?.size.height ?? 100
        cLetter.offsetXY.0 = Double.random(in: -(width/2 - cLetter.size/4 - 3)...(width/2 - cLetter.size/4 - 3))
        cLetter.offsetXY.1 = Double.random(in: -(height/2 - cLetter.size/4 - 3)...(height/2 - cLetter.size/4 - 3))
    }
    
    mutating func freezeLetter() {
        cLetter.isFrozen.toggle()
    }
    
    mutating private func resetTriggers() {
        correctResponseTrigger = false
        wrongResponseTrigger = false
    }
    
}
