//
//  CGameDocument.swift
//  BetterSight
//
//  Created by f on 9.03.2022.
//

import Foundation
import SwiftUI

class CGame: ObservableObject {
    @Published var letters: [CLetter] {
        didSet { scheduleAutosave() }
    }
   
    // Setting to 3 by default. 3 means 'basic game' -> 4th letter. If game is structured this variable will be set by tabs. If not, it will be set to 3 when the settings sheet is dissmissed.
    @Published var activeTabIDX: Int = 3 {
        didSet {
            formerTabIDX = oldValue
            saveActiveTabState()
        }
    }
    var formerTabIDX = 0
    
    var letter: CLetter {
        get {
            switch activeTabIDX {
            case 0: return letters[0]
            case 1: return letters[1]
            case 2: return letters[2]
            case 3: return letters[3]
            default: return letters[0]
            }
        } set {
            switch activeTabIDX {
            case 0: letters[0] = newValue
            case 1: letters[1] = newValue
            case 2: letters[2] = newValue
            case 3: letters[3] = newValue
            default: letters[3] = newValue
            }
        }
    }
    
    init() {
        letters = [CLetter(), CLetter(), CLetter(), CLetter()]
        restoreCurrentState()
    }
    
    // MARK: - AutoSave
    private var userDefaultsKey: String {
        "currentGame"
    }
    
    private var autosaveTimer: Timer?
    private func scheduleAutosave() {
        autosaveTimer?.invalidate()
        autosaveTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            self.saveCurrentState()
        }
    }
    
    private func saveCurrentState() {
        UserDefaults.standard.set(try? JSONEncoder().encode(letters), forKey: userDefaultsKey)
    }
    
    private func restoreCurrentState() {
        getActiveTabState()
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey) {
            if let decodedData = try? JSONDecoder().decode([CLetter].self, from: data) {
                if decodedData.count == 4 {
                    letters = decodedData
                }
            }
        } else {
            // Initiate from start
            letters = [CLetter(), CLetter(), CLetter(), CLetter()]
        }
    }
    
    func saveActiveTabState() {
        UserDefaults.standard.set(activeTabIDX, forKey: userDefaultsKey+"activeTabState")
    }
    // Returns 0 if can't find a state.
    func getActiveTabState() {
        let data = UserDefaults.standard.integer(forKey: userDefaultsKey+"activeTabState")
        activeTabIDX = data
    }

    
    // MARK: - Settings:

    var settings: SettingComponents?
    
    func updateSettings(_ newSettings: SettingComponents) {
        for i in 0..<letters.count {
            letters[i].roundUpSize = newSettings.cSizeAtStart
            letters[i].shrinkageRate = newSettings.shrinkageRate
        }
        
        if !newSettings.gameModeIsStructured { activeTabIDX = 3 }
        else if newSettings.gameModeIsStructured, activeTabIDX == 3 {
            activeTabIDX = 0
        }
    }
    
    
    
    //MARK: - Intent(s)
    
    var correctResponseTrigger = false
    var wrongResponseTrigger = false
    var fetchedGeometry: GeometryProxy?
    let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
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
        letter.text = String(alphabet.randomElement() ?? "A")
        
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
    }
    
    func activateLetterMovement() {
        // When deactivated, takes the letter to center.
        if letter.isMoving {
            letter.offsetX = 0
            letter.offsetY = 0
        }
        letter.isMoving.toggle()
    }
    
    func restart() {
        letter = CLetter(size: letter.roundUpSize,
                         roundUpSize: letter.roundUpSize,
                         shrinkageRate: letter.shrinkageRate)
    }

    func offsetCRandomly() {
        let width = fetchedGeometry?.size.width ?? 800
        let height = fetchedGeometry?.size.height ?? 800
        let x = Double.random(in: -(width/2 - letter.size/4 - 3)...(width/2 - letter.size/4 - 3))
        let y = Double.random(in: -(height/2 - letter.size/4 - 3)...(height/2 - letter.size/4 - 3))
        
        letter.offsetX = x
        letter.offsetY = y
    }
    
    // Stops the shrinking after correct aswers.
    func freezeLetter() {
        letter.isFrozen.toggle()
    }
    
    private func resetTriggers() {
        correctResponseTrigger = false
        wrongResponseTrigger = false
    }
    
}


