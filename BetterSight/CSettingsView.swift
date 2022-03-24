//
//  CSettingsView.swift
//  BetterSight
//
//  Created by f on 8.03.2022.
//

import SwiftUI

struct CSettingsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var settings: CSettings
    
    let cSizes: [Double] = [1, 2, 3, 4, 5]
    let shrinkageRates: [String] = ["Low", "Medium", "High"]
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color.brown.opacity(0.5).edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("C Size On Start:")
                        .bolderWithPadding()
                        .putOnLeading()
                    startPicker
                        .padding(.bottom)
                   
                    Divider()
                    
                    Text("C Size After Each Round:")
                        .bolderWithPadding()
                        .putOnLeading()
                    afterRoundPicker
                        .padding(.bottom)
                  
                    Divider()
                    
                    Text("Shrinkage Rate:")
                        .bolderWithPadding()
                        .putOnLeading()
                    shrinkagePicker
                        .padding(.bottom)
                        .padding(.bottom)
                  
                    Divider()
                    Group {
                        checkToggle
                        Divider()
                        xToggle
                    }
                }
                .padding()
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: saveButton)
            .navigationBarItems(leading: resetButton)
        }
    }
    
    
    
    var startPicker: some View {
        Picker("CSizeOnStart", selection: $settings.settingComponents.cSizeAtStart) {
            ForEach(cSizes, id: \.self) {
                Text($0, format: .number)
            }
        }
        .pickerStyle(.segmented)
        .colorMultiply(Color(white: 0.9))
    }
    
    var afterRoundPicker: some View {
        Picker("CSizeAfterRound", selection: $settings.settingComponents.cSizeAfterEachRound) {
            ForEach(cSizes, id: \.self) {
                Text($0, format: .number)
            }
        }
        .pickerStyle(.segmented)
        .colorMultiply(Color(white: 0.9))
    }
    
    var shrinkagePicker: some View {
        Picker("Shrinkage Rate", selection: $settings.settingComponents.shrinkageRate) {
            ForEach(shrinkageRates, id: \.self) {
                Text($0)
            }
        }
        .pickerStyle(.segmented)
        .colorMultiply(Color(white: 0.9))
    }
    
    var checkToggle: some View {
        Toggle(isOn: $settings.settingComponents.showingCheckmark) {
            Text("Show Checkmark")
                .fontWeight(.heavy)
        }
        .tint(Color(white: 0.3))
    }
    
    var xToggle: some View {
        Toggle(isOn: $settings.settingComponents.showingXmark) {
            Text("Show Xmark")
                .fontWeight(.heavy)
        }
        .tint(Color(white: 0.3))
    }
    
    var saveButton: some View {
        Button {
            dismiss()
        } label: {
            Text("Save")
                .fontWeight(.heavy)
                .foregroundColor(Color(white: 0.3))
        }
    }
    
    var resetButton: some View {
        Button {
            settings.reset()
        } label: {
            Text("Reset")
                .fontWeight(.heavy)
                .foregroundColor(Color(white: 0.3))
        }
    }
        
}

extension Text {
    func bolderWithPadding() -> some View {
        self
            .foregroundColor(Color(white: 0.4))
            .fontWeight(.heavy)
            .padding(.horizontal)
    }
}

extension View {
    func putOnLeading() -> some View {
        HStack {
            self
            Spacer()
        }
    }
}

struct CSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        CSettingsView()
    }
}
