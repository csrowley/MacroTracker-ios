import SwiftUI
import SwiftData

struct EnterMealView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \DailyEntries.date, order: .reverse) var allDays: [DailyEntries] // Query to fetch all logs
    
    @State private var viewModel = ViewModel()
    @State private var showAlert = false
    
    let checkDate = Calendar.current.dateComponents([.day, .year, .month], from: Date())

    
    let dailyMeals = ["Breakfast", "Lunch", "Dinner", "Snack"]
    
    var todays_log: DailyEntries? {
        allDays.first
    }

    var body: some View {
        NavigationStack {
            Form {
                Picker("Choose a Meal", selection: $viewModel.selectedMeal) {
                    ForEach(dailyMeals, id: \.self) { dailyMeal in
                        Text(dailyMeal)
                    }
                } 
                
                HStack {
                    Text("Meal Name:")
                    TextField("Enter Meal Name", text: $viewModel.mealName)
                        .multilineTextAlignment(.trailing)
                }
                
                HStack {
                    Text("Servings Amount :")
                    TextField("1", text: $viewModel.servingAmount)
                        .keyboardType(.numbersAndPunctuation)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.blue)
                }
                
                Section {
                    HStack {
                        Text("Calories:")
                        TextField("Enter Calorie Amount", text: $viewModel.calData)
                            .keyboardType(.numbersAndPunctuation)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Protein (g):")
                        TextField("Enter Protein Amount", text: $viewModel.proteinData)
                            .keyboardType(.numbersAndPunctuation)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Carbs (g):")
                        TextField("Enter Carb Amount", text: $viewModel.carbData)
                            .keyboardType(.numbersAndPunctuation)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Fats (g):")
                        TextField("Enter Fat Amount", text: $viewModel.fatData)
                            .keyboardType(.numbersAndPunctuation)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Spacer()
                        Button{
                            if let cals = Int(viewModel.calData),
                               let protein = Int(viewModel.proteinData),
                               let carbs = Int(viewModel.carbData),
                               let fats = Int(viewModel.fatData),
                               let servings = Int(viewModel.servingAmount){
                                
                                logUserMacros(uMeal: viewModel.selectedMeal, uName: viewModel.mealName, cals: cals * servings, protein: protein * servings, carb: carbs * servings, fat: fats * servings)
                            } else {
                                showAlert = true
                            }
                        } label: {
                            CircleLogButton(user_color1: Color.green, user_color2: Color.green, icon: "checkmark", noPortal: true)
                        }
                        .alert("Invalid meal entry", isPresented: $showAlert){
                            Button("Ok", role: .cancel){}
                        }
                        Spacer()
                    }
                }
            }
        }
        .font(Font.custom("Lato", size: 18)) // Set your custom font and size

        .background(Color(UIColor.systemGray6)) // Match the background color
        
 
    }
    
    func logUserMacros(uMeal: String, uName: String, cals: Int, protein: Int, carb: Int, fat: Int) {
        let userMacroEntry = MacroEntry(meal: uMeal, name: uName, entryCals: cals, entryProtein: protein, entryCarb: carb, entryFat: fat)
        
        //Enter into storage
        if let todaysLog = allDays.first{
            let mealTypeDict = [
                "breakfast" : todaysLog.breakfast,
                "lunch" : todaysLog.lunch,
                "dinner" : todaysLog.dinner,
                "snacks" : todaysLog.snacks
            ]
            
            mealTypeDict[uMeal]?.entries.append(userMacroEntry)
        }
        
        
        //Update progress to show on homescreen
        
    }
    
}

#Preview {
    EnterMealView()
}
