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
    
    let cSizes: [Double] = [1, 2, 3, 4, 5]
    let shrinkageRates: [String] = ["Low", "Medium", "High"]
    
    var body: some View {
        NavigationView {
            Form {
                Section("C Size On Start") {
                    Picker("CSizeOnStart", selection: $settings.settingComponents.cSizeAtStart) {
                        ForEach(cSizes, id: \.self) {
                            Text($0, format: .number)
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section("C Size After Each Round") {
                    Picker("CSizeAfterRound", selection: $settings.settingComponents.cSizeAfterEachRound) {
                        ForEach(cSizes, id: \.self) {
                            Text($0, format: .number)
                        }
                    }.pickerStyle(.segmented)
                }

                Section("Shrinkage Rate") {
                    Picker("Shrinkage Rate", selection: $settings.settingComponents.shrinkageRate) {
                        ForEach(shrinkageRates, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Save") { dismiss() } )
            .navigationBarItems(leading: Button("Reset") { settings.reset() })
        }
    }
}

struct CSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        CSettingsView()
    }
}
