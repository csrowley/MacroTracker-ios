//
//  Macros.swift
//  MacroTracker
//
//  Created by Chris Rowley on 6/20/24.
//

import Foundation
import SwiftData

struct MacroVals {
    let protein: Int = 4
    let carb: Int = 4
    let fat: Int = 9
}

//will store entries as MacroEntry objects
@Model
class MacroEntry: Identifiable {
    @Attribute(.unique) var uid: UUID
    @Attribute var entryDate: Date
    @Attribute var meal: String
    @Attribute var name: String = ""
    
    @Attribute var entryCals: Int = 0
    @Attribute var entryProtein: Int = 0
    @Attribute var entryCarb: Int = 0
    @Attribute var entryFat: Int = 0
    
    init(uid: UUID = UUID(), entryDate: Date = Date(), meal: String, name: String, entryCals: Int, entryProtein: Int, entryCarb: Int, entryFat: Int) {
        self.uid = uid
        self.entryDate = stripTime(from: entryDate)
        self.meal = meal
        self.name = name
        self.entryCals = entryCals
        self.entryProtein = entryProtein
        self.entryCarb = entryCarb
        self.entryFat = entryFat
    }
    
}

@Model
class Meals{
    @Attribute(.unique) var meals: String
    @Attribute var entries: [MacroEntry]
    
    init(meals: String, entries: [MacroEntry] = []) {
        self.meals = meals
        self.entries = entries
    }
    
    func addToEntries(_ entry: MacroEntry) {
        entries.append(entry)
    }
}

@Model
class DailyEntries{
    @Attribute(.unique) var uid: UUID
    @Attribute(.unique) var date: Date
    @Attribute var allMeals: [Meals]
    
    init(uid: UUID = UUID(), date: Date = Date(), allMeals: [Meals] = []) {
        self.uid = uid
        self.date = stripTime(from: date)
        self.allMeals = allMeals
    }
    
    func addToMeals(_ meal: Meals) {
        allMeals.append(meal)
    }
}

struct TargetMacros {
    private(set) var targetCalories: Int = 2000
    private(set) var targetProtein: Int = 150
    private(set) var targetCarb: Int = 250
    private(set) var targetFat: Int = 70
    
    mutating func setTargetMacros(cals: Int = 0, protein: Int = 0, carb: Int = 0, fat: Int = 0) {
        targetCalories = cals
        targetProtein = protein
        targetCarb = carb
        targetFat = fat
    }
}

//user will fill out the macros and calories, and will be sent to DailyGoals object
struct DailyProgress {
    var breakfastCals : Int? = 0
    var breakfastMacros : MacroEntry? = nil
    
    var lunchCals : Int? = 0
    var lunchMacros : MacroEntry? = nil
    
    var dinnerCals : Int? = 0
    var dinnerMacros : MacroEntry? = nil
}

func stripTime(from date: Date) -> Date {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day], from: date)
    return calendar.date(from: components)!
}
