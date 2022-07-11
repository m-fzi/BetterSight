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
    
    var size: Double = LetterConstants.size
    var roundUpSize: Double = LetterConstants.size
    var shrinkageRate: Double = LetterConstants.shrinkageRate
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
    var text = "A"
}

// When the app launches for the first time-Settings view is not dissmissed yet-, we will be able to keep sync between settings and default letter constants.
struct LetterConstants {
    static let size: Double = 300
    static let shrinkageRate: Double = 0.8
    static let rawSize: Double = 4
    static let rawShrinkageRate = "Medium"
}
