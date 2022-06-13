//
//  ProgressTracker.swift
//  BetterSight
//
//  Created by f on 16.03.2022.
//

import Foundation
import SwiftUI

class ProgressTracker: ObservableObject {
    
    @Published private(set) var sessions = [WorkoutSession]()
    
    let pathOfSavedProgress = FileManager.documentsDirectory.appendingPathComponent("SavedProgress")
    init() {
        do {
            let data = try Data(contentsOf: pathOfSavedProgress)
            sessions = try JSONDecoder().decode([WorkoutSession].self, from: data)
        } catch {
            sessions = Array<WorkoutSession>()
            uniqueSessionIdOverAll = 0
        }
    }
    
    // MARK: - Intents:
    private var uniqueSessionIdOverAll = 0
    private var uniqueSessionIdForKind = 0
    
    // kind: cames from activeTabIDX on game. 0-left, 1-right, 2-both, 3-basicGame
    func addSession(game: CGame) {
        calculateUniqueSessionIDs(game: game)
        
        sessions.insert(WorkoutSession(roundAmount: game.letter.round, wrongAnswerCount: game.letter.wrongAnswerCount, kind: game.activeTabIDX, sessionCounter: uniqueSessionIdForKind, id: uniqueSessionIdOverAll), at: 0)
        
        save()
    }
    
    func calculateUniqueSessionIDs(game: CGame) {
        uniqueSessionIdOverAll = 0
        uniqueSessionIdForKind = 0
        if sessions.count > 0 {
            uniqueSessionIdOverAll = sessions[0].id
            
            let filteredSessionsForKind = sessions.filter { $0.kind == game.activeTabIDX }
            if !filteredSessionsForKind.isEmpty {
                uniqueSessionIdForKind = filteredSessionsForKind[0].sessionCounter
            }
        }
        uniqueSessionIdOverAll += 1
        uniqueSessionIdForKind += 1
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(sessions)
            try data.write(to: pathOfSavedProgress, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func clear() {
        sessions = [WorkoutSession]()
        uniqueSessionIdOverAll = 0
        uniqueSessionIdForKind = 0
        save()
    }
    
    // Identifying the 'to be removed' session because 'offsets' parameter the view passes in is index inside that selected kind. Not index of that session in the whole list of sessions.
    func remove(at offsets: IndexSet, sessionKind: Int) {
        let idOfToBeRemovedSession = sessions.filter { $0.kind == sessionKind }[offsets.last!].id
        sessions.removeAll(where: { $0.id == idOfToBeRemovedSession })
        save()
    }
    
}
