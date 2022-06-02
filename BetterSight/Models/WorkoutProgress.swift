//
//  WorkoutProgress.swift
//  BetterSight
//
//  Created by f on 16.03.2022.
//

import Foundation

struct WorkoutProgress: Codable {
    var sessions = [WorkoutSession]()
    
    struct WorkoutSession: Codable, Identifiable {
        var bothRoundAmount: Int
        var bothWrongAnswerCount: Int
        var leftRoundAmount: Int
        var leftWrongAnswerCount: Int
        var rightRoundAmount: Int
        var rightWrongAnswerCount: Int
        var id: Int
        
        
        fileprivate init(bothRoundAmount: Int, bothWrongAnswerCount: Int, leftRoundAmount: Int, leftWrongAnswerCount: Int, rightRoundAmount: Int, rightWrongAnswerCount: Int, id: Int) {
            self.bothRoundAmount = bothRoundAmount
            self.bothWrongAnswerCount = bothWrongAnswerCount
            self.leftRoundAmount = leftRoundAmount
            self.leftWrongAnswerCount = leftWrongAnswerCount
            self.rightRoundAmount = rightRoundAmount
            self.rightWrongAnswerCount = rightWrongAnswerCount
            self.id = id
        }
    }
    
    init() { }
    
    mutating func addSession(bothRoundAmount: Int, bothWrongAnswerCount: Int, leftRoundAmount: Int, leftWrongAnswerCount: Int, rightRoundAmount: Int, rightWrongAnswerCount: Int, id: Int) {
        
        sessions.insert(WorkoutSession(bothRoundAmount: bothRoundAmount, bothWrongAnswerCount: bothWrongAnswerCount, leftRoundAmount: leftRoundAmount, leftWrongAnswerCount: leftWrongAnswerCount, rightRoundAmount: rightRoundAmount, rightWrongAnswerCount: rightWrongAnswerCount, id: id), at: 0)
    }
}
