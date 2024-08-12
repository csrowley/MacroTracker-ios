//
//  MacroTrackerApp.swift
//  MacroTracker
//
//  Created by Chris Rowley on 6/20/24.
//

import SwiftUI
import SwiftData

@main
struct MacroTrackerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            MacroEntry.self,
            Meals.self,
            DailyEntries.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            HomePage()
                .modelContainer(sharedModelContainer)
        }
        .modelContainer(sharedModelContainer)
    }
}
