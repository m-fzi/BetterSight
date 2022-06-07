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
    
    var body: some View {
        VStack {
            ProgressTrackerViewTabBar(tabIndex: $tabIndex)
            
            switch tabIndex {
            case 1: leftProgressView
            case 2: rightProgressView
            case 3: bothProgressView
            default: allProgressView
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
    
    func deleteSession(at offsets: IndexSet) {
        progress.remove(at: offsets)
    }
    
    var allProgressView: some View {
        Form {
            ForEach(progress.sessions) { session in
                Section(header: Text("Workout Session \(session.id)")) {
                    List {
                        HStack {
                            Text("Both:")
                                .fontWeight(.heavy)
                            Text("\(session.bothWrongAnswerCount) wrong anwers in \(session.bothRoundAmount) rounds")
                        }
                        HStack {
                            Text("Left:")
                                .fontWeight(.heavy)
                            Text("\(session.leftWrongAnswerCount) wrong anwers in \(session.leftRoundAmount) rounds")
                        }
                        HStack {
                            Text("Right:")
                                .fontWeight(.heavy)
                            Text("\(session.rightWrongAnswerCount) wrong anwers in \(session.rightRoundAmount) rounds")
                        }
                    }
                }
            }
            .onDelete(perform: deleteSession)
        }
        
    }
    
    var leftProgressView: some View {
        Form {
            ForEach(progress.sessions) { session in
                HStack {
                    Text("\(session.leftWrongAnswerCount) wrong answers in \(session.leftRoundAmount) rounds")
                    Spacer()
                    Text("Session \(session.id)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .onDelete(perform: deleteSession)
        }
    }
    
    var rightProgressView: some View {
        Form {
            ForEach(progress.sessions) { session in
                HStack {
                    Text("\(session.rightWrongAnswerCount) wrong answers in \(session.rightRoundAmount) rounds")
                    Spacer()
                    Text("Session \(session.id)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .onDelete(perform: deleteSession)
        }
    }
    
    var bothProgressView: some View {
        Form {
            ForEach(progress.sessions) { session in
                HStack {
                    Text("\(session.bothWrongAnswerCount) wrong answers in \(session.bothRoundAmount) rounds")
                    Spacer()
                    Text("Session \(session.id)")
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
