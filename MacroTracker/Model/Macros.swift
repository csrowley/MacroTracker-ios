//
//  Macros.swift
//  MacroTracker
//
//  Created by Chris Rowley on 6/20/24.
//

import Foundation
import SwiftData

enum MacroVals{
    case protein(_ val: Int)
    case carb(_ val: Int)
    case fat(_ val: Int)
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
    
    @Relationship(deleteRule: .cascade, inverse: \Meals.entries) var parentMeals: Meals?
    
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
    @Attribute(.unique) var uid: UUID
    @Attribute(.unique) var meals: String
    @Relationship(deleteRule: .cascade, inverse: \MacroEntry.meal) var entries: [MacroEntry] = []
    
    init(uid: UUID = UUID(), meals: String) {
        self.uid = uid
        self.meals = meals
    }
    
    func addToEntries(_ entry: MacroEntry) {
        entries.append(entry)
    }
}

@Model
class DailyEntries{
    @Attribute(.unique) var uid: UUID
    @Attribute(.unique) var date: Date
    
    @Relationship(deleteRule: .cascade) var breakfast: Meals
    @Relationship(deleteRule: .cascade) var lunch: Meals
    @Relationship(deleteRule: .cascade) var dinner: Meals
    @Relationship(deleteRule: .cascade) var snacks: Meals
    
    @Attribute var calProgress: Int
    @Attribute var proteinProgress: Int
    @Attribute var carbProgress: Int
    @Attribute var fatProgress: Int
    
    init(uid: UUID = UUID(), date: Date = Date(), cals: Int, protein: Int, carb: Int, fat: Int, breakfast: Meals, lunch: Meals, dinner: Meals, snacks: Meals) {
        self.uid = uid
        self.date = stripTime(from: date)
        self.calProgress = cals
        self.proteinProgress = protein
        self.fatProgress = fat
        self.carbProgress = carb
        
        self.breakfast = breakfast
        self.lunch = lunch
        self.dinner = dinner
        self.snacks = snacks
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
