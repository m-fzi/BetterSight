//
//  ProgressTracker.swift
//  BetterSight
//
//  Created by f on 16.03.2022.
//

import Foundation
import SwiftUI

class ProgressTracker: ObservableObject {
    
    @Published private(set) var progressModel = WorkoutProgress()
    
    let pathOfSavedProgress = FileManager.documentsDirectory.appendingPathComponent("SavedProgress")
    init() {
        do {
            let data = try Data(contentsOf: pathOfSavedProgress)
            progressModel.sessions = try JSONDecoder().decode([WorkoutProgress.WorkoutSession].self, from: data)
        } catch {
            progressModel.sessions = Array<WorkoutProgress.WorkoutSession>()
            uniqueSessionID = 0
        }
    }
    
    var sessions: Array<WorkoutProgress.WorkoutSession> {
        progressModel.sessions
    }

    
    // MARK: - Intents:
    private var uniqueSessionID = 0
    func addSession(gameLeft: CGameViewModel, gameRight: CGameViewModel, gameBoth: CGameViewModel) {
        if progressModel.sessions.count > 0 {
            uniqueSessionID = sessions[0].id
        }
        uniqueSessionID += 1
        progressModel.addSession(bothRoundAmount: gameBoth.cLetter.round, bothWrongAnswerCount: gameBoth.cLetter.wrongAnswerCount, leftRoundAmount: gameLeft.cLetter.round, leftWrongAnswerCount: gameLeft.cLetter.wrongAnswerCount, rightRoundAmount: gameRight.cLetter.round, rightWrongAnswerCount: gameRight.cLetter.wrongAnswerCount, id: uniqueSessionID)
        
        save()
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(sessions)
            try data.write(to: pathOfSavedProgress, options: [.atomic, .completeFileProtection])
        } catch {
            print("unable to save data")
        }
    }
    
    func clear() {
        progressModel.sessions = [WorkoutProgress.WorkoutSession]()
        uniqueSessionID = 0
        save()
    }
    
    func remove(at offsets: IndexSet) {
        progressModel.sessions.remove(atOffsets: offsets)
        save()
    }
    
}
