//
//  ContentView.swift
//  BetterSight
//
//  Created by f on 31.01.2022.
//

import SwiftUI

struct MainView: View {
    @State private var moveViewTo: String? = nil
    @State private var showingCSettings = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(white: 0.85)
                    .edgesIgnoringSafeArea(.all)
                cWorkoutButton
                    .frame(width: geo.size.width / 1.1, height: 150)
                cSettingsButton
                    .position(x: geo.size.width / 2, y: geo.size.height / 1.45)
                
            }
            .navigate(to: CView(), tag: "CView", binding: $moveViewTo)
            .sheet(isPresented: $showingCSettings) {
                CSettingsView()
            }
        }
    }
    
    var cWorkoutButton: some View {
        Button {
            moveViewTo = "CView"
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .strokeBorder(.gray, lineWidth: 4)
                    .background(RoundedRectangle(cornerRadius: 25).fill(.white))
                HStack {
                    Text("C")
                        .font(.custom("OpticianSans-Regular", size: 100))
                    Text("Workout")
                        .font(.headline)
                }
            }
            .padding()
            .foregroundColor(.black)
        }
    }
    
    var cSettingsButton: some View {
        Button {
            showingCSettings = true
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .strokeBorder(.gray, lineWidth: 4)
                    .background(RoundedRectangle(cornerRadius: 25).fill(.white))
                Image(systemName: "gearshape")
                    .resizable()
                    .foregroundColor(.black)
                    .padding()
            }
        }
        .frame(width: 100, height: 100)
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
