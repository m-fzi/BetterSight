//
//  CGame.swift
//  BetterSight
//
//  Created by f on 8.03.2022.
//

import Foundation

struct CLetter: Codable {
    enum Direction: CaseIterable, Codable {
        case right, up, left, down
    }
    
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
    var offsetX: Double = 0
    var offsetY: Double = 0
    var isFrozen = false
    var isMoving = false
    var wrongAnswerCount = 0
    var round = 0
    var id = 0
}
