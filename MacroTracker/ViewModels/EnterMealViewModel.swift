//
//  EnterMealViewModel.swift
//  MacroTracker
//
//  Created by Chris Rowley on 8/26/24.
//

import Foundation

extension EnterMealView{
    @Observable
    class ViewModel{
        
        var calData: String = ""
        var carbData: String = ""
        var proteinData: String = ""
        var fatData: String = ""
        var selectedMeal: String = "Breakfast"
        var mealName: String = ""
        var servingAmount: String = "1"
        
        
        private func enterUserMeal() {
            
        }
    }
}
