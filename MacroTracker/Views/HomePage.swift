import SwiftUI
import SwiftData

struct HomePage: View {
    @AppStorage("firstTimeLaunch") private var checkFirstLaunch: Bool = true
    @AppStorage("showHome") private var showHomeButton: Bool = false
    @AppStorage("setCalories") private var dailyCals: Int = 2600
    @AppStorage("setProtein") private var dailyProteins: Int = 100
    @AppStorage("setCarbs") private var dailyCarbs: Int = 100
    @AppStorage("setFats") private var dailyFats: Int = 100
    
//    @AppStorage("calProgress") private var calProgress: Int = 0
//    @AppStorage("proteinProgress") private var proteinProgress: Int?
//    @AppStorage("carbProgress") private var carbProgress: Int?
//    @AppStorage("fatProgress") private var fatProgress: Int?
    
    @State private var viewModel = ViewModel()
    @Environment(\.modelContext) private var context
    @Query(sort: \DailyEntries.date, order: .reverse) var allDays: [DailyEntries] // Query to fetch all logs
    

    
    
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
                                    "Lato",
                                    fixedSize: 30)
                                )
                            HStack{
                                Spacer()
                                var checkCalProgress = allDays.first?.calProgress ?? 0
                                CircleProgressBar(progress: checkCalProgress, calories: abs(dailyCals - checkCalProgress), user_color: Color(lavander))
                                    .frame(width: 250, height: 225)
                                Spacer()
                            }
                        }
                    }
                    
                    
                    Section {
                        VStack {
                            HStack {
                                Text("Protein")
                                Spacer()
                            }
                            var checkProteinProgress = allDays.first?.proteinProgress ?? 0
                            ProgressBar(progress: Double(checkProteinProgress / 100), macros: abs(checkProteinProgress - dailyProteins), user_color: Color(scarlet))
                        }
                        VStack {
                            HStack {
                                Text("Carbs")
                                Spacer()
                            }
                            var checkCarbProgress = allDays.first?.carbProgress ?? 0
                            ProgressBar(progress: Double(checkCarbProgress / 100), macros: abs(checkCarbProgress - dailyCarbs), user_color: Color(royal_blue))
                        }
                        VStack {
                            HStack {
                                Text("Fats")
                                Spacer()
                            }
                            var checkFatProgress = allDays.first?.fatProgress ?? 0
                            ProgressBar(progress: Double(checkFatProgress / 100), macros: abs(checkFatProgress - dailyFats), user_color: Color(tangerine))
                        }
                    }

                    .scrollContentBackground(.hidden)
                    
                    
                }
                
                .background(Color.clear)
                .scrollContentBackground(.hidden)
                
                
                HStack{
                    Button("press"){
                        checkFirstLaunch.toggle()
                        showHomeButton.toggle()
                        
                    }
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
    	
//    func addProgress(cals: Int, protein: Int, carbs: Int, fats: Int){
//        if let calProgress,
//           let proteinProgress,
//           let carbProgress,
//           let fatProgress{
//            
//        }
//    }
}



#Preview {
    HomePage()
}
