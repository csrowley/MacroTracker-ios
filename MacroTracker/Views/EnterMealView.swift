import SwiftUI
import SwiftData

struct EnterMealView: View {
    @AppStorage("calProgress") private var calorieProgress: Int?
    @AppStorage("proteinProgress") private var proteinProgress: Int?
    @AppStorage("carbProgress") private var carbProgress: Int?
    @AppStorage("fatProgress") private var fatProgress: Int?
    
//    @AppStorage("setCalories") private var dailyCals: Int?
//    @AppStorage("setProtein") private var dailyProteins: Int?
//    @AppStorage("setCarbs") private var dailyCarbs: Int?
//    @AppStorage("setFats") private var dailyFats: Int?
    
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
                            if let calors = Int(viewModel.calData),
                               let proteins = Int(viewModel.proteinData),
                               let carbs = Int(viewModel.carbData),
                               let fats = Int(viewModel.fatData),
                               let servings = Int(viewModel.servingAmount){
                                
                                logUserMacros(uMeal: viewModel.selectedMeal, uName: viewModel.mealName, cals: calors * servings, protein: proteins * servings, carb: carbs * servings, fat: fats * servings)
                                
                                print("after servings")
                                print(servings)
                                print(calors * servings)
                                print(proteins * servings)
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
        .font(Font.custom("Lato", size: 18))

        .background(Color(UIColor.systemGray6))
        
 
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
            
            addProgress(cals: cals, protein: protein, carbs: carb, fats: fat)
        }
        
    }
    
    func addProgress(cals: Int, protein: Int, carbs: Int, fats: Int){
        if let unwrapCal = calorieProgress,
           let unwrapProtein = proteinProgress,
           let unwrapCarbs = carbProgress,
           let unwrapFats = fatProgress{
//           let tCals = dailyCals,
//           let tProtein = dailyProteins,
//           let tCarbs = dailyCarbs,
//           let tFats = dailyFats{
            
//            print(calorieProgress!)
            
            calorieProgress! += cals
            proteinProgress! += protein
            carbProgress! += carbs
            fatProgress! += fats
            
//            print(calorieProgress!)
        }
    }
    
}

#Preview {
    EnterMealView()
}
