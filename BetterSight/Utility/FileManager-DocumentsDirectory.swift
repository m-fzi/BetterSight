//
//  FileManager-DocumentsDirectory.swift
//  BetterSight
//
//  Created by f on 19.03.2022.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

