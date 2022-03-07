//
//  CViewInfoSheet.swift
//  BetterSight
//
//  Created by f on 21.02.2022.
//

import SwiftUI

struct CViewInfoSheet: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("Press the direction of C for correct answer.")
                
                Spacer()
                
                VStack {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder()
                            .frame(height: 80)
                        HStack {
                            Text("Tap")
                            Image(systemName: "arrow.counterclockwise")
                                .frame(width: 35, height: 35)
                                .foregroundColor(.white)
                                .background(.gray)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .scaleEffect(0.7)
                            Text("to restart.")
                        }
                        .padding()
                    }
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder()
                            .frame(height: 80)
                        HStack {
                            Text("Activate")
                            Image(systemName: "snowflake")
                                .frame(width: 35, height: 35)
                                .foregroundColor(.white)
                                .background(.gray)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .scaleEffect(0.7)
                            Text("to freeze C at current size.")
                        }
                        .padding()
                    }
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder()
                            .frame(height: 80)
                        HStack {
                            Text("Activate")
                            Image(systemName: "move.3d")
                                .frame(width: 35, height: 35)
                                .background(.gray)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .scaleEffect(0.7)
                            Text("to move C after every correct answer.")
                        }
                        .padding()
                    }
                    
                   
                }
                .padding()
                Spacer()
            }
            .navigationTitle("How to play")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Done") { dismiss() } )
            .background(Color(white: 0.9))
//            .opacity(0.3)
        }
    }
    
}

struct CViewInfoSheet_Previews: PreviewProvider {
    static var previews: some View {
        CViewInfoSheet()
    }
}
