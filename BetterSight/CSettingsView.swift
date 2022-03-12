//
//  CSettingsView.swift
//  BetterSight
//
//  Created by f on 8.03.2022.
//

import SwiftUI

struct CSettingsView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var settings = CSettings()
    
    let cSizes: [Double] = [60, 100, 200, 300, 400]
    let shrinkageRates: [Double] = [0.7, 0.8, 0.9]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("CSizeOnStart", selection: $settings.settingComponents.cSizeAtStart) {
                        ForEach(cSizes, id: \.self) {
                            Text($0, format: .number)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("C Size On Start")
                }
                
                Section {
                    Picker("CSizeAfterRound", selection: $settings.settingComponents.cSizeAfterEachRound) {
                        ForEach(cSizes, id: \.self) {
                            Text($0, format: .number)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("C Size After Each Round")
                }

                Section {
                    Picker("Shrinkage Rate", selection: $settings.settingComponents.shrinkageRate) {
                        ForEach(shrinkageRates, id: \.self) {
                            Text($0, format: .number)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Shrinkage Rate")
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Save") {
                dismiss() } )
            .navigationBarItems(leading: Button("Reset") { settings.reset() })
        }
    }
}

struct CSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        CSettingsView()
    }
}
