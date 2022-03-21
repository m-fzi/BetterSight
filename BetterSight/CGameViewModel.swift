//
//  CGameDocument.swift
//  BetterSight
//
//  Created by f on 9.03.2022.
//

import Foundation
import SwiftUI

class CGameViewModel: ObservableObject {
    
    @Published private(set) var model: CGame
    
    init() {
        model = CGame(cLetter: CGame.CLetter())
    }

    var cLetter: CGame.CLetter {
        model.cLetter
    }
    
    var correctResponseTrigger : Bool {
        model.correctResponseTrigger
    }
    
    var wrongResponseTrigger: Bool {
        model.wrongResponseTrigger
    }
    
    
    //MARK: - Indent(s)
    
    func chooseDirection(direction: CGame.Direction) {
        model.chooseDirection(direction)
    }
    
    func restart() {
        model = CGame(cLetter: CGame.CLetter())
    }
    
    func moveLetter() {
        model.toggleLetterMovement()
    }
    
    func freeze() {
        model.freezeLetter()
    }
    
    func fetchGeometry(_ geometry: GeometryProxy) {
        model.fetchedGeometry = geometry
    }
}
