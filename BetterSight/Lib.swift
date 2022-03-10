//
//  SpecialViewsCollection.swift
//  BetterSight
//
//  Created by f on 6.02.2022.
//

import SwiftUI

struct Lib {
    @State private var colorOfControlGround = Color.white
    func changeTheColorOfControlGround(color: Color) {
        withAnimation {
            colorOfControlGround = color
        }
        // wait for ..
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
            // Back to normal with ease animation
            withAnimation {
                colorOfControlGround = Color.white
            }
        })
    }
}





