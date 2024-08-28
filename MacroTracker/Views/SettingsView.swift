//
//  SettingsView.swift
//  MacroTracker
//
//  Created by Chris Rowley on 8/25/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack{
            List{
                NavigationLink(destination: SetUserGoalsView()){
                    Text("Set Goals")
                }
//                NavigationLink(destination: SetUserGoalsView()){
//                    Text("Profile")
//                }
//                NavigationLink(destination: SetUserGoalsView()){
//                    Text("TDEE Calculator")
//                }
                
                //add TDEE Calc
                //add profile (height, weight, etc)
            }
            .font(Font.custom("Lato", size: 18))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Settings")
                        .bold()
                        .font(Font.custom("Montserrat", size: 20))
                }
            }

        }
        
    }
}

#Preview {
    SettingsView()
}
