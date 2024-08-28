import SwiftUI
import SwiftData

struct HomePage: View {
    @AppStorage("firstTimeLaunch") private var checkFirstLaunch: Bool = true
    @AppStorage("showHome") private var showHomeButton: Bool = false

    @State private var viewModel = ViewModel()

    
    @Environment(\.modelContext) private var context
    @Query(sort: \DailyEntries.date, order: .reverse) var allDays: [DailyEntries] // Query to fetch all logs
    
    @AppStorage("setCalories") private var dailyCals: Int = 2600

    @AppStorage("setProtein") private var dailyProteins: Int = 25
    @AppStorage("setCarbs") private var dailyCarbs: Int = 50
    @AppStorage("setFats") private var dailyFats: Int = 25
    
    
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
                                CircleProgressBar(progress: viewModel.progress_cals, calories: dailyCals, user_color: Color(lavander))
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
                            ProgressBar(progress: viewModel.progress_protein,
                                        macros: Int((Double(dailyProteins) / 100) * Double(dailyCals)) / 4,
                                        user_color: Color(scarlet))

                            
                        }
                        VStack{
                            HStack{
                                Text("Carbs")
                                
                                Spacer()
                            }
                            ProgressBar(progress: viewModel.progress_carbs,
                                        macros: Int((Double(dailyCarbs) / 100) * Double(dailyCals)) / 4,
                                        user_color: Color(royal_blue))
                        }
                        VStack{
                            HStack{
                                Text("Fats")
                                
                                Spacer()
                            }
                                
                            ProgressBar(progress: viewModel.progress_fats,
                                        macros: Int((Double(dailyFats) / 100) * Double(dailyCals)) / 9,
                                        user_color: Color(tangerine))
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
}



#Preview {
    HomePage()
}
