//
//  CGameDocument.swift
//  BetterSight
//
//  Created by f on 9.03.2022.
//

import Foundation
import SwiftUI

class CGame: ObservableObject {
    
    @Published var letter = CLetter() {
        didSet { scheduleAutosave() }
    }
    
    init(gameID: String) {
        self.gameID = gameID
        restoreCurrentState()
    }
    
    var gameID: String
    private var userDefaultsKey: String {
        "currentGame" + gameID
    }
    
    private func saveCurrentState() {
        UserDefaults.standard.set(try? JSONEncoder().encode(letter), forKey: userDefaultsKey)
    }
    
    private func restoreCurrentState() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey) {
           if let decodedData = try? JSONDecoder().decode(CLetter.self, from: data) {
               letter = decodedData
           }
        }
    }
    
    private var autosaveTimer: Timer?
    private func scheduleAutosave() {
        autosaveTimer?.invalidate()
        autosaveTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            self.saveCurrentState()
        }
    }
    
    
    var correctResponseTrigger = false
    var wrongResponseTrigger = false
    var fetchedGeometry: GeometryProxy?
//    var roundUpTrigger = false
    
    let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    //MARK: - Indent(s)
    
    func chooseDirection(direction: CLetter.Direction) {
        resetTriggers()
        if direction == letter.direction {
            correctAnswer()
        } else {
            wrongAnswer()
        }
    }
    
    func chooseSnellenLetter(letterText: String) {
        resetTriggers()
        if letterText == letter.text {
            correctAnswerForSnellen()
        } else {
            wrongAnswer()
        }
        
    }
    
    private var rotationDegrees: [Double] = [0, 90, 180, 270]
    private func correctAnswer() {
        letter.rotation = rotationDegrees.randomElement() ?? 0
        
        if !letter.isFrozen && letter.size >= 8 {
            letter.size = letter.size * letter.shrinkageRate
        } else if letter.size < 8 {
            roundUp()
        }
  
        correctResponseTrigger = true
    }
    
    private func wrongAnswer() {
        letter.wrongAnswerCount += 1
        wrongResponseTrigger = true
    }
    
    private func correctAnswerForSnellen() {
        letter.text = String(letters.randomElement() ?? "A")
        
        if !letter.isFrozen && letter.size >= 8 {
            letter.size = letter.size * letter.shrinkageRate
        } else if letter.size < 8 {
            roundUp()
        }
  
        correctResponseTrigger = true
    }
    
    private func roundUp() {
        letter.round += 1
        letter.size = letter.roundUpSize
//        roundUpTrigger = true
    }
    
    func activateLetterMovement() {
        if letter.isMoving {
            letter.offsetX = 0
            letter.offsetY = 0
        }
        letter.isMoving.toggle()
    }
    
    func restart() {
        letter = CLetter()
    }

    func offsetCRandomly() {
        let width = fetchedGeometry?.size.width ?? 800
        let height = fetchedGeometry?.size.height ?? 800
        let x = Double.random(in: -(width/2 - letter.size/4 - 3)...(width/2 - letter.size/4 - 3))
        let y = Double.random(in: -(height/2 - letter.size/4 - 3)...(height/2 - letter.size/4 - 3))
        
        letter.offsetX = x
        letter.offsetY = y
    }
    
    func freezeLetter() {
        letter.isFrozen.toggle()
    }
    
    private func resetTriggers() {
        correctResponseTrigger = false
        wrongResponseTrigger = false
//        roundUpTrigger = false
    }
    
}
