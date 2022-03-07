//
//  NavigationExtension.swift
//  BetterSight
//
//  Created by f on 5.02.2022.
//

import SwiftUI

extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, tag: String, binding: Binding<String?>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                NavigationLink(destination: view.navigationBarTitle("").navigationBarHidden(true),
                               tag: tag,
                               selection: binding) {
                                EmptyView()
                                }
            }
        }
        .navigationViewStyle(.stack)
        .statusBar(hidden: true)
    }
}
