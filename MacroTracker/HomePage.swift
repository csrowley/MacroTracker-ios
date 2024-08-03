import SwiftUI

struct HomePage: View {
    @State var progress_cals: Double = 0.0
    @State var progress_protein: Double = 0.0
    @State var progress_carbs: Double = 0.0
    @State var progress_fats: Double = 0.0

    @State var calories: Int = 2500
    
    @State var isPresented_Log = false
    
    init() {
        // Set the appearance of UINavigationBar with a lighter purple color
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor(red: (145/255), green: (80/255), blue: (230/255), alpha: 1.0) // Light purple

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
                                .font(.title)
                            HStack{
                                Spacer()
                                CircleProgressBar(progress: progress_cals, calories: calories)
                                    .frame(width: 250, height: 250)
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
                            ProgressBar(progress: progress_protein, macros: 100, user_color: Color.red) //placeholder number
                        }
                        VStack{
                            HStack{
                                Text("Carbs")
                                Spacer()
                            }
                            ProgressBar(progress: progress_carbs, macros: 100, user_color: Color.blue) //placeholder number
                        }
                        VStack{
                            HStack{
                                Text("Fats")
                                Spacer()
                            }
                            ProgressBar(progress: progress_fats, macros: 100, user_color: Color.orange) //placeholder number
                        }
                        
                    }
                    
                    
                    //
                    //                Button("Reset"){
                    //                    resetProgress()
                    //                }
                    //                Button("Add"){
                    //                    addProgress()
                    //                }
                }
                .background(Color(UIColor.systemGray6)) // Match the background color

                CircleLogButton(user_color1: Color.purple, user_color2: Color.blue, text: "+", noPortal: false)
                
                
                .navigationTitle("Macrometer")
                .navigationBarTitleDisplayMode(.inline)
            }
            .background(Color(UIColor.systemGray6))
 
        }
    }
    
//    func resetProgress(){
//        progress_cals = 0
//        progress_protein = 0
//        progress_carbs = 0
//        progress_fats = 0
//        calories = 0
//    }
    
//    func addProgress(){
//        // change so will stop adding progress when target is hit
//        // if progress_protein >= target_fats {return}
//        progress_cals += 0.1
//        progress_protein += 0.1
//        progress_carbs += 0.1
//        progress_fats += 0.1
//        calories += 100
//    }
}


#Preview {
    HomePage()
}
