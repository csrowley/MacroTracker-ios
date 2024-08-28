//
//  FirstLaunchView.swift
//  MacroTracker
//
//  Created by Chris Rowley on 8/26/24.
//

import SwiftUI
import SwiftData

struct FirstLaunchView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @Query(sort: \DailyEntries.date, order: .reverse) var allDays: [DailyEntries]
    
    
    @AppStorage("showHome") private var showHomeButton: Bool = false
    var body: some View {
        NavigationStack{
            
            VStack(spacing:20){
                Text("👋 Welcome to Macrometer")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)
                
                Text("To get started, first enter some information about your macronutrient goals.")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
        
                
                if showHomeButton == true{
                    NavigationLink(destination: EmptyView()){
                        Button{
                            initalizeUserStorage()
                            print(allDays)
                            dismiss()
                        } label: {
                            CircleLogButton(user_color1: Color.purple, user_color2: Color.blue, icon: "house", noPortal: true)

                        }
                    }
                }

                else{
                    NavigationLink(destination: SetUserGoalsView()){
                        CircleLogButton(user_color1: Color.purple, user_color2: Color.blue, icon: "arrowshape.right.fill", noPortal: true)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Macrometer")
                        .font(Font.custom("Montserrat", size:30))
                }
            }
        }
        .font(Font.custom("Lato", size:24))
    }
    
    func initalizeUserStorage(){
        let firstDailyEntry = DailyEntries(breakfast: Meals(meals: "breakfast"), lunch: Meals(meals: "lunch"), dinner: Meals(meals: "dinner"), snacks: Meals(meals: "snacks"))
        context.insert(firstDailyEntry)
    }
}

#Preview {
    FirstLaunchView()
}