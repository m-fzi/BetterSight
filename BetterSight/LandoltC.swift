//
//  SpecialViewsCollection.swift
//  BetterSight
//
//  Created by f on 6.02.2022.
//

import SwiftUI

struct LandoltC: View {
    var sizeOfC: CGFloat
    var rotation: Double = 0
    var offsetXY: (Double, Double) = (0, 0)
    
    var body: some View {
        Text("C")
            .font(.custom("OpticianSans-Regular", size: sizeOfC))
            .rotationEffect(Angle(degrees: rotation))
            .offset(x: offsetXY.0, y: offsetXY.1)
    }
}

enum Directions: CaseIterable {
    case right, up, left, down
}


