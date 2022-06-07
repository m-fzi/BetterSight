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
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Group {
                        Group {
                            Text("Manuel C Workout: Press the direction of C for correct answer.")
                            Divider()
                            Text("Speech C Workout: Say Right, Left, Up or Down.")
                            Divider()
                            Text("Snellen Workout: Say a random word that starts with the letter you see.")
                            Divider() }
                        Text("You can see your current workout round and total wrong answer count for the selected side on top of the workout screen.")
                        Divider()
                        Text("You can work on and keep track of your left, right and both sides in one workout session.")
                        Divider()
                        Text("To save the workout, press Save|Redo button when you finish the session.")
                        Divider()
                        Text("You can also activate the letter movement or freeze the letter size. To do this, press gear shape in workout screen and adjust the settings.")
                    }
                    
                    Spacer()
                    
                    VStack {
                        Link(destination: URL(string: "https://github.com/m-fzi/BetterSight/blob/main/PrivacyPolicy.md")!) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .strokeBorder()
                                    .frame(height: 80)
                                    .foregroundColor(.black)
                                Text("Privacy Policy")
                                    .fontWeight(.heavy)
                                    .foregroundColor(.black)
                            }
                        }
                    } .padding()
                    Spacer()
                }
                .padding()
                .navigationTitle("How to play")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: Button("Done") { dismiss() } )
                .background(Color(hue: 0.4, saturation: 0.3, brightness: 0.7))
            }
        }
    }
    
}

struct InfoSheet_Previews: PreviewProvider {
    static var previews: some View {
        InfoSheet()
    }
}
