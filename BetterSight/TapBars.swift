//
//  ProgressViewTapBar.swift
//  BetterSight
//
//  Created by f on 16.03.2022.
//

import SwiftUI

struct CGameViewTapBar: View {
    @Binding var tabIndex: Int
    var body: some View {
        HStack(spacing: 0) {
            CGameViewTapBarButton(text: "Left", isSelected: .constant(tabIndex == 0))
                .onTapGesture { onButtonTapped(index: 0) }
            CGameViewTapBarButton(text: "Right", isSelected: .constant(tabIndex == 1))
                .onTapGesture { onButtonTapped(index: 1) }
            CGameViewTapBarButton(text: "Both", isSelected: .constant(tabIndex == 2))
                .onTapGesture { onButtonTapped(index: 2) }
        }
    }
    
    private func onButtonTapped(index: Int) {
        withAnimation { tabIndex = index }
    }
}

struct CGameViewTapBarButton: View {
    let text: String
    @Binding var isSelected: Bool
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 100, height: 30)
                .foregroundColor(isSelected ? .gray : .white)
            Text(text)
                .fontWeight(.heavy)
                .foregroundColor(isSelected ? .white : .black)
                
        }
    }
}

struct ProgressTrackerViewTabBar: View {
    @Binding var tabIndex: Int
    var body: some View {
        HStack(spacing: 0) {
            ProgressViewTabBarButton(text: "All", isSelected: .constant(tabIndex == 0))
                .onTapGesture { onButtonTapped(index: 0) }
            ProgressViewTabBarButton(text: "Left", isSelected: .constant(tabIndex == 1))
                .onTapGesture { onButtonTapped(index: 1) }
            ProgressViewTabBarButton(text: "Right", isSelected: .constant(tabIndex == 2))
                .onTapGesture { onButtonTapped(index: 2) }
            ProgressViewTabBarButton(text: "Both", isSelected: .constant(tabIndex == 3))
                .onTapGesture { onButtonTapped(index: 3) }
        }
    }
    
    private func onButtonTapped(index: Int) {
        withAnimation { tabIndex = index }
    }
}

struct ProgressViewTabBarButton: View {
    let text: String
    @Binding var isSelected: Bool
    var body: some View {
        ZStack {
            Rectangle()
                .stroke()
                .frame(width: 90, height: 30)
            Rectangle()
                .foregroundColor(isSelected ? .gray : .white)
                .frame(width: 90, height: 30)
            Text(text)
                .fontWeight(.heavy)
                .foregroundColor(isSelected ? .white : .black)
                
        }
    }
}

