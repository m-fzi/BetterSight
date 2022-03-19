//
//  CheckMark.swift
//  BetterSight
//
//  Created by f on 19.03.2022.
//

import SwiftUI

struct CheckMark: View {
    var body: some View {
        VStack {
            Image(systemName: "checkmark.square")
                .resizable()
                .frame(width: 300, height: 300)
                .foregroundColor(.green)
            
            Image(systemName: "xmark.square")
                .resizable()
                .frame(width: 300, height: 300)
                .foregroundColor(.red)
        }
        
        
    }
}

struct CheckMark_Previews: PreviewProvider {
    static var previews: some View {
        CheckMark()
    }
}
