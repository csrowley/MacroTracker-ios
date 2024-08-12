import SwiftUI
import SwiftData

class MacroManager: ObservableObject {
    @Published var dailyCals: Int = 2000
    @Published var dailyCarbs: Int = 275
    @Published var dailyProtein: Int = 110
    @Published var dailyFats: Int = 56
}

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \DailyEntries.date, order: .reverse) var allDays: [DailyEntries] // Query to fetch all logs
    @StateObject private var macroManager = MacroManager()
    
    @State private var calData: String = ""
    @State private var carbData: String = ""
    @State private var proteinData: String = ""
    @State private var fatData: String = ""
    @State private var selectedMeal: String = "Breakfast"
    @State private var mealName: String = ""
    @State private var servingAmount: String = "1"
    
    let checkDate = Calendar.current.dateComponents([.day, .year, .month], from: Date())

    
    let dailyMeals = ["Breakfast", "Lunch", "Dinner", "Snack"]
    
    var todays_log: DailyEntries? {
        allDays.first
    }

    var body: some View {
        NavigationStack {
            Form {
                Picker("Choose a Meal", selection: $selectedMeal) {
                    ForEach(dailyMeals, id: \.self) { dailyMeal in
                        Text(dailyMeal)
                    }
                }
                
                HStack {
                    Text("Meal Name:")
                    TextField("Enter Meal Name", text: $mealName)
                        .multilineTextAlignment(.trailing)
                }
                
                HStack {
                    Text("Servings Amount :")
                    TextField("1", text: $servingAmount)
                        .keyboardType(.numbersAndPunctuation)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.blue)
                }
                
                Section {
                    HStack {
                        Text("Calories:")
                        TextField("Enter Calorie Amount", text: $calData)
                            .keyboardType(.numbersAndPunctuation)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Protein (g):")
                        TextField("Enter Protein Amount", text: $proteinData)
                            .keyboardType(.numbersAndPunctuation)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Carbs (g):")
                        TextField("Enter Carb Amount", text: $carbData)
                            .keyboardType(.numbersAndPunctuation)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Fats (g):")
                        TextField("Enter Fat Amount", text: $fatData)
                            .keyboardType(.numbersAndPunctuation)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Spacer()
                        Button(action: {
                            // Ensure safe unwrapping of optional values
                            if let cals = Int(calData),
                               let protein = Int(proteinData),
                               let carbs = Int(carbData),
                               let fats = Int(fatData),
                               let servings = Int(servingAmount){
                            
                                
                                logUserMacro(cals: cals * servings, protein: protein * servings, carb: carbs * servings, fat: fats * servings)
                            } else {
                                print("Invalid input")
                            }
                        }) {
                            CircleLogButton(user_color1: Color.green, user_color2: Color.green, text: "Log", noPortal: true)
                        }
                        Spacer()
                    }
                }
            }
        }
        .background(Color(UIColor.systemGray6)) // Match the background color
    }
    
    private func logUserMacro(cals: Int, protein: Int, carb: Int, fat: Int) {
        let userEntry = MacroEntry(meal: selectedMeal, name: mealName, entryCals: cals, entryProtein: protein, entryCarb: carb, entryFat: fat)
        context.insert(userEntry)
        
        do {
            try context.save()
            print("success")
        } catch {
            print("error saving entry \(error.localizedDescription)")
        }
    }
    
}

#Preview {
    ContentView()
}
