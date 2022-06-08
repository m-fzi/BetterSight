//
//  ProgressTrackerView.swift
//  BetterSight
//
//  Created by f on 16.03.2022.
//

import SwiftUI

struct ProgressTrackerView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var tabIndex = 0
    @State private var showingClearHistoryAlert = false
    
    @EnvironmentObject var progress: ProgressTracker
    @EnvironmentObject var settings: CSettings
    
    var body: some View {
        VStack {
            if settings.settingComponents.gameModeIsStructured {
                ProgressTrackerViewTabBar(tabIndex: $tabIndex)
                switch tabIndex {
                case 0: leftProgressView
                case 1: rightProgressView
                case 2: bothProgressView
                default: leftProgressView
                }
            } else {
                basicProgressView
            }
        }
        .navigationTitle("Workout History")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .navigationBarItems(trailing: clearButton)
        .alert("Delete sessions", isPresented: $showingClearHistoryAlert) {
            Button("Clear", role: .destructive, action: progress.clear)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Do you want to clear workout history?")
        }
    }
    
    var backButton: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.backward.square")
                .resizable()
                .foregroundColor(Color(white: 0.2))
                .frame(width: 30, height: 30)
        }
    }
    
    var clearButton: some View {
        Button {
            showingClearHistoryAlert = true
        } label: {
            Text("Clear")
        }
    }
    
    // Basic game session kinds are 3. Number comes from CGame. 
    func deleteSession(at offsets: IndexSet) {
        progress.remove(at: offsets, sessionKind: settings.settingComponents.gameModeIsStructured ? tabIndex : 3)
    }
    
    var leftProgressView: some View {
        Form {
            ForEach(progress.sessions.filter { $0.kind == 0 }) { session in
                HStack {
                    Text("\(session.wrongAnswerCount) wrong answers in \(session.roundAmount) rounds")
                    Spacer()
                    Text("Session \(session.sessionCounter)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .onDelete(perform: deleteSession)
        }
    }
    
    var rightProgressView: some View {
        Form {
            ForEach(progress.sessions.filter { $0.kind == 1 }) { session in
                HStack {
                    Text("\(session.wrongAnswerCount) wrong answers in \(session.roundAmount) rounds")
                    Spacer()
                    Text("Session \(session.sessionCounter)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .onDelete(perform: deleteSession)
        }
    }
    
    var bothProgressView: some View {
        Form {
            ForEach(progress.sessions.filter { $0.kind == 2 }) { session in
                HStack {
                    Text("\(session.wrongAnswerCount) wrong answers in \(session.roundAmount) rounds")
                    Spacer()
                    Text("Session \(session.sessionCounter)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .onDelete(perform: deleteSession)
        }
    }
    
    var basicProgressView: some View {
        Form {
            ForEach(progress.sessions.filter { $0.kind == 3 }) { session in
                HStack {
                    Text("\(session.wrongAnswerCount) wrong answers in \(session.roundAmount) rounds")
                    Spacer()
                    Text("Session \(session.sessionCounter)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .onDelete(perform: deleteSession)
        }
    }
}



struct ProgressTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressTrackerView()
    }
}
