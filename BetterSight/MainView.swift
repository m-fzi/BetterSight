//
//  ContentView.swift
//  BetterSight
//
//  Created by f on 31.01.2022.
//

import SwiftUI

struct MainView: View {
    @State private var moveViewTo: String? = nil
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.gray.edgesIgnoringSafeArea(.all)
                    .opacity(0.5)
                Button {
                    moveViewTo = "CView"
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.white)
                            .opacity(1)
                            .shadow(radius: 10)
                        HStack {
                            Text("C")
                                .font(.custom("OpticianSans-Regular", size: 100))
                            Text("Workout")
                                .font(.headline)
                        }
                    }
                    .frame(width: geo.size.width / 1.1, height: 100)
                    .padding()
                    .foregroundColor(.black)
                }
            }
            .navigate(to: CView(), tag: "CView", binding: $moveViewTo)
        }
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
