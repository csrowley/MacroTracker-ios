//
//  HomePageViewModel.swift
//  MacroTracker
//
//  Created by Chris Rowley on 8/26/24.
//

import Foundation
import SwiftUI
import SwiftData

extension HomePage{
    
    @Observable
    class ViewModel {
        let lavander = UIColor(red: 0.827, green: 0.827, blue: 1, alpha: 1)
        let ivory = UIColor(red: 1.0, green: 1.0, blue: 0.89, alpha: 1.0)
        let royal_blue = UIColor(red: 48/255.0, green: 92/255.0, blue: 222/255.0, alpha: 1.0)
        let scarlet = UIColor(red: 0.91, green: 0.196, blue: 0.337, alpha: 1)
        let tangerine = UIColor(red: 1, green: 0.659, blue: 0, alpha: 1)
        
        
        var progress_cals: Double = 0
        var progress_protein: Double = 0
        var progress_carbs: Double = 0
        var progress_fats: Double = 0
    }
}
