//
//  CGameDocument.swift
//  BetterSight
//
//  Created by f on 9.03.2022.
//

import Foundation
import SwiftUI

class CGameViewModel: ObservableObject {
    typealias CLetter = CGame.CLetter
    
    @Published private var model: CGame
    
    init() {
        model = CGame(cLetter: CGame.CLetter())
    }

    var cLetter: CGame.CLetter {
        model.cLetter
    }
    
    
    //MARK: - Indent(s)
    
    func chooseDirection(direction: CGame.Direction, inGeometry: GeometryProxy) {
        model.chooseDirection(direction, inGeometry)
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
    

}
