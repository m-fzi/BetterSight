//
//  CSettingsView.swift
//  BetterSight
//
//  Created by f on 8.03.2022.
//

import SwiftUI

struct CSettingsView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var preferredCSizeOnStart = 3
    @State private var preferredCSizeAfterRound = 3
    let shrinkageRates = ["slow", "medium", "fast"]
    @State private var shrinkageRate = "medium"
    
    
    let cSizes = [1, 2, 3, 4, 5]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("CSizeOnStart", selection: $preferredCSizeOnStart) {
                        ForEach(cSizes, id: \.self) {
                            Text($0, format: .number)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("C Size On Start")
                }
                
                Section {
                    Picker("CSizeAfterRound", selection: $preferredCSizeAfterRound) {
                        ForEach(cSizes, id: \.self) {
                            Text($0, format: .number)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("C Size After Each Round")
                }
                
                Section {
                    Picker("Shrinkage Rate", selection: $shrinkageRate) {
                        ForEach(shrinkageRates, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Shrinkage Rate")
                }
            }
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: Button("Done") { dismiss() } )
        }
        
    }
}

struct CSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        CSettingsView()
    }
}
