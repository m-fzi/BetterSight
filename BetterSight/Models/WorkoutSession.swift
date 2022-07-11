//
//  WorkoutProgress.swift
//  BetterSight
//
//  Created by f on 16.03.2022.
//

import Foundation

struct WorkoutSession: Codable, Identifiable {
    var roundAmount: Int
    var wrongAnswerCount: Int
    var kind: Int
    var sessionCounter: Int
    var id: Int
}
