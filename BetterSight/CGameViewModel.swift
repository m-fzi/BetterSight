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
    
    var fetchedGeometry: GeometryProxy?
    
    //MARK: - Indent(s)
    
    func chooseDirection(direction: CGame.Direction) {
        model.chooseDirection(direction)
    }
    
    func restart() {
        model = CGame(cLetter: CGame.CLetter())
    }
    
    func activateLetterMovement() {
        model.toggleLetterMovement()
    }
    
    func offsetCRandomly() {
        let width = fetchedGeometry?.size.width ?? 800
        let height = fetchedGeometry?.size.height ?? 800
        let x: Double = Double.random(in: -(width/2 - cLetter.size/4 - 3)...(width/2 - cLetter.size/4 - 3))
        let y :Double = Double.random(in: -(height/2 - cLetter.size/4 - 3)...(height/2 - cLetter.size/4 - 3))
        model.offsetC(x: x, y: y)
    }
    
    func freeze() {
        model.freezeLetter()
    }
}
