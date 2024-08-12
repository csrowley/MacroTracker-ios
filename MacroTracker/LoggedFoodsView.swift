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
    @Query(sort: \MacroEntry.uid, order: .reverse) var allLogs: [MacroEntry]
//    @StateObject private var macroManager = MacroManager()
    
    @State private var viewedDate: String = "Today"
    var body: some View {
        NavigationStack{

            List{
//                Section {
//                    Text("Breakfast")
//                    ForEach(allLogs){ log in
//                        Text("\(log.entryCals) - \(log.entryDate)")
//                    }
//                }
//                
//                Section {
//                    Text("Lunch")
//                    ForEach(allLogs){ log in
//                        Text("\(log.entryCals) - \(log.entryDate)")
//                    }
//                }
//                
//                Section{
//                    Text("Dinner")
//                    ForEach(allLogs){ log in
//                        Text("\(log.entryCals) - \(log.entryDate)")
//                    }
//                }
            }

            
                .navigationTitle(viewedDate)
                .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    LoggedFoodsView()
}
