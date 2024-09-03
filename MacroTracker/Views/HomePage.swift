import SwiftUI
import SwiftData

struct HomePage: View {
    @AppStorage("firstTimeLaunch") private var checkFirstLaunch: Bool = true
    @AppStorage("showHome") private var showHomeButton: Bool = false
    
    @AppStorage("setCalories") private var dailyCals: Int?
    @AppStorage("setProtein") private var dailyProteins: Int?
    @AppStorage("setCarbs") private var dailyCarbs: Int?
    @AppStorage("setFats") private var dailyFats: Int?
    
    @State private var viewModel = ViewModel()
    @Environment(\.modelContext) private var context
    @Query(sort: \DailyEntries.date, order: .reverse) var allDays: [DailyEntries] // Query to fetch all logs
    
    @AppStorage("calProgress") private var calorieProgress: Int?
    @AppStorage("proteinProgress") private var proteinProgress: Int?
    @AppStorage("carbProgress") private var carbProgress: Int?
    @AppStorage("fatProgress") private var fatProgress: Int?
    
    
    @State private var test = 0
    @State private var refreshTrigger = false
    @State var isPresented_Log = false
    @State var showLogView = false
    
    
    init() {
        // Set the appearance of UINavigationBar with a lighter purple color
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor(red: 1.0, green: 1.0, blue: 0.89, alpha: 1.0)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = viewModel.lavander // Light purple
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        if calorieProgress == nil{
            calorieProgress = 0
        }
        if proteinProgress == nil{
            proteinProgress = 0
        }
        if carbProgress == nil{
            proteinProgress = 0
            
        }
        if fatProgress == nil{
            fatProgress = 0
        }
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
                                    "Lato",
                                    fixedSize: 30)
                                )
                            HStack{
                                Spacer()
                                var unwrappedCals = dailyCals ?? 1
                                CircleProgressBar(progress: Double(calorieProgress ?? 1) / Double(unwrappedCals),
                                                 calories: abs(unwrappedCals - (calorieProgress ?? 0)),
                                                  user_color: Color(viewModel.lavander))

                                Spacer()
                            }
//                            Button("reset"){
//                                if let _ = calorieProgress{
//                                    calorieProgress! = 0
//                                }
//                                else{
//                                    calorieProgress = 0
//                                }
//                            }
                            Spacer()
                        }
                        
                    }
                    
                    
                    Section {
//                        Button("press"){
//                            if let _ = calorieProgress{
//                                calorieProgress! += 200
//                            }
//                            else{
//                                calorieProgress = 300
//                            }
//                        }
                        VStack {
                            HStack {
                                Text("Protein")
                                Spacer()
                            }
                            
                            var unwrappedProtein = (dailyProteins ?? 1)
                            
                            ProgressBar(progress: Double(proteinProgress ?? 1) / Double(unwrappedProtein), macros: abs((proteinProgress ?? 0) - unwrappedProtein), user_color: Color(viewModel.scarlet))
                        }
                        VStack {
                            HStack {
                                Text("Carbs")
                                Spacer()
                            }
                            var unwrappedCarbs = (dailyCarbs ?? 1)
                            
                            ProgressBar(progress: Double(carbProgress ?? 1) / Double(unwrappedCarbs), macros: abs((carbProgress ?? 0) - unwrappedCarbs), user_color: Color(viewModel.royal_blue))
                        }
                        VStack {
                            HStack {
                                Text("Fats")
                                Spacer()
                            }
                            let unwrappedFats = (dailyFats ?? 1)

                            ProgressBar(progress: Double(fatProgress ?? 1) / Double(unwrappedFats), macros: abs((fatProgress ?? 0) - unwrappedFats), user_color: Color(viewModel.tangerine))
                        }
                    }

                    .scrollContentBackground(.hidden)
                    
                    
                }
                
                .background(Color.clear)
                .scrollContentBackground(.hidden)
                
                
                HStack{
//                    
//                    Button("press"){
//                        checkFirstLaunch.toggle()
//                        showHomeButton.toggle()
//                        
//                    }
                    
                    var reset_instruction = {
                        
                        calorieProgress = 0
                        proteinProgress = 0
                        fatProgress = 0
                        carbProgress = 0
                        
                        
                        let newDailyEntry = DailyEntries(
                            breakfast: Meals(meals: "breakfast"),
                            lunch: Meals(meals: "lunch"),
                            dinner: Meals(meals: "dinner"),
                            snacks: Meals(meals: "snacks")
                        )
                        context.insert(newDailyEntry)
                    }
                    

                    ResetLogButton(user_color1: Color.purple, user_color2: Color.blue, instruction: reset_instruction)

                    CircleLogButton(user_color1: Color.purple, user_color2: Color.blue, icon: "plus", noPortal: false)
                    
                    NavigationLink(destination: LoggedFoodsView(), isActive: $showLogView){EmptyView()}
                    
                    UserLogsButton(user_color1: Color.purple, user_color2: Color.blue, toggleView: $showLogView)

                        

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
                        ToolbarItem{
                            NavigationLink(destination: SettingsView()){
                                Image(systemName: "gearshape.fill")
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(Color(.white))
                            }
                                    
        
                        }
                    }
                
            }
            
        }
        .font(Font.custom("Lato", size: 18))
        .fullScreenCover(isPresented: $checkFirstLaunch, content: {
            FirstLaunchView()
//            checkFirstLaunch = false
        })
        

    }
    
//    func resetAndCreateNewLog(){
//        
//    }
    	
}



#Preview {
    HomePage()
}
