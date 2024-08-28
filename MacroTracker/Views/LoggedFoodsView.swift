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
    
    @State private var viewedDate: String = "Today"
    var body: some View {
        NavigationStack{

            List{
                Section {
                    Text("Test")
                    ForEach(allLogs){ log in
                        Text("\(log.entryCals) - \(log.entryDate)")
                    }
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
