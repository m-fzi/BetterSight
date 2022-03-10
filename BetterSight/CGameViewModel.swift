//
//  CGameDocument.swift
//  BetterSight
//
//  Created by f on 9.03.2022.
//

import Foundation

class CGameViewModel: ObservableObject {
    typealias CLetter = CGame.CLetter
    
    private static func makeCGame() -> CGame {
        CGame(cLetter: CGame.CLetter())
    }
    
    @Published private var model = makeCGame()
    
    var cLetter: CGame.CLetter {
        model.cLetter
    }
    
    
    
    //MARK: - Indent(s)
    
    func chooseDirection(_ key: CGame.Direction) {
        model.chooseDirection(key)
    }
    
    func restart() {
        model = CGameViewModel.makeCGame()
    }
    
    func moveLetter() {
        model.toggleLetterMovement()
    }
    
    func freeze() {
        model.freezeLetter()
    }
    

}
