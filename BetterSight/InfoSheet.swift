//
//  CViewInfoSheet.swift
//  BetterSight
//
//  Created by f on 21.02.2022.
//

import SwiftUI

struct InfoSheet: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Group {
                    Text("Press the direction of C for correct answer.")
                    Divider()
                    Text("You can work on and keep track of your left, right and both sides in one workout session.")
                    Divider()
                    Text("You can see your current workout round and total wrong answer count for selected side on top of the screen.")
                    Divider()
                    Text("To save the workout to keep track of your progress, press Save|Redo button when you finish the session.")
                    Divider()
                    Text("To activate the letter movement or freeze the letter size, press gear shape in workout screen.")
                }
                
                Spacer()
                
                VStack {
                    Link(destination: URL(string: "https://github.com/m-fzi/BetterSight/blob/main/PrivacyPolicy.md")!) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder()
                                .frame(height: 80)
                            Text("Privacy Policy")
                                .fontWeight(.heavy)
                                .foregroundColor(.blue)
                        }
                    }
                } .padding()
                
                Spacer()
            }
            .padding()
            .navigationTitle("How to play")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Done") { dismiss() } )
            .background(Color(white: 0.9))
        }
    }
    
}

struct InfoSheet_Previews: PreviewProvider {
    static var previews: some View {
        InfoSheet()
    }
}
