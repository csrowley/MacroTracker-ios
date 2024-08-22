import SwiftUI
import SwiftData

struct HomePage: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \DailyEntries.date, order: .reverse) var allDays: [DailyEntries] // Query to fetch all logs
    
    
    @State var progress_cals: Double = 0.25
    @State var progress_protein: Double = 0.25
    @State var progress_carbs: Double = 0.25
    @State var progress_fats: Double = 0.25
    
    @State var calories: Int = 2500
    
    @State var isPresented_Log = false
    
    let lavander = UIColor(red: 0.827, green: 0.827, blue: 1, alpha: 1)
    let ivory = UIColor(red: 1.0, green: 1.0, blue: 0.89, alpha: 1.0)
    let royal_blue = UIColor(red: 48/255.0, green: 92/255.0, blue: 222/255.0, alpha: 1.0)
    let scarlet = UIColor(red: 0.91, green: 0.196, blue: 0.337, alpha: 1)
    let tangerine = UIColor(red: 1, green: 0.659, blue: 0, alpha: 1)
    
    init() {
        // Set the appearance of UINavigationBar with a lighter purple color
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor(red: 1.0, green: 1.0, blue: 0.89, alpha: 1.0)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = lavander // Light purple
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationStack {
            
            VStack {
                Form{
                    Section{
                        VStack{
                            Text("Calories Remaining")
                                .font(
                                    .custom(
                                    "Montserrat",
                                    fixedSize: 30)
                                )
                            HStack{
                                Spacer()
                                CircleProgressBar(progress: progress_cals, calories: calories, user_color: Color(lavander))
                                    .frame(width: 250, height: 225)
                                Spacer()
                            }
                        }
                    }
                    
                    
                    Section{
                        VStack{
                            HStack{
                                Text("Protein")
                                Spacer()
                            }
                            ProgressBar(progress: progress_protein, macros: 100, user_color: Color(scarlet)) //placeholder number
                        }
                        VStack{
                            HStack{
                                Text("Carbs")

                                Spacer()
                            }
                            ProgressBar(progress: progress_carbs, macros: 100, user_color: Color(royal_blue)) //placeholder number
                        }
                        VStack{
                            HStack{
                                Text("Fats")

                                Spacer()
                            }
                            ProgressBar(progress: progress_fats, macros: 100, user_color: Color(tangerine)) //placeholder number
                        }
                        
                    }
                    .scrollContentBackground(.hidden)
                    
                    
                }
                
                .background(Color.clear) // Match the background color
                .scrollContentBackground(.hidden)
                
                
                HStack{
                    ResetLogButton(user_color1: Color.purple, user_color2: Color.blue, noPortal: false)
                    CircleLogButton(user_color1: Color.purple, user_color2: Color.blue, icon: "plus", noPortal: false)
                    UserLogsButton(user_color1: Color.purple, user_color2: Color.blue, noPortal: false)

                }
                
                
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("Macrometer")
                                .font(
                                    .custom("Montserrat", size: 30)
                                )
                                .foregroundColor(.white)
                        }
                    }
                
            }
            
        }
        .font(Font.custom("Lato", size: 18))
        
    }
    
    
//    private func createTodaysEntry() {
//        let mealNames = ["Breakfast", "Lunch", "Dinner", "Snacks"]
//        
//        let newDateEntry = DailyEntries()
//        
//        for name in mealNames {
//            let newMeal = Meals(meals: name, entries: [])
//            newDateEntry.addToMeals(newMeal)
//            
//        }
//        
//        context.insert(newDateEntry)
//        
//        do {
//            try context.save()
//            print("success")
//        } catch {
//            print("error saving entry \(error.localizedDescription)")
//        }
//    }
}



#Preview {
    HomePage()
}
