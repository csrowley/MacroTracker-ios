//
//  LoggedFoodsView.swift
//  MacroTracker
//
//  Created by Chris Rowley on 8/5/24.
//

import SwiftUI
import SwiftData

struct LoggedFoodsView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \DailyEntries.date, order: .reverse) var allLogs: [DailyEntries]
    
    @State private var viewedDate: String = "Today"
    var body: some View {
        NavigationStack{

            List{
                Section {
                    if let todayLog = allLogs.first{
                        var todaysBreakfast = todayLog.breakfast
                        ForEach(todaysBreakfast.entries) { meal in
                            Text("\(meal.name) : Cals: \(meal.entryCals) Carbs: \(meal.entryCarb)")
                        }
                    }
                    else{
                        Text("No content available currently")
                    }
//                    ForEach(todaysLog){ log in
//                        Text("\(log.uid)")
//                    }
                }
            }

            
                .navigationTitle(viewedDate)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    Button("Reset"){
                        Text("h")
                    }
                }
        }
        
        .font(Font.custom("Lato", size: 18)) // Set your custom font and size

    }
    
}

#Preview {
    LoggedFoodsView()
}
