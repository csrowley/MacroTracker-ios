import SwiftUI

struct CircleLogButton: View {
    @State private var animation_count = 1.0
    @State private var isPresented_Log = false
    
    let user_color1: Color
    let user_color2: Color
    let icon: String
    let noPortal: Bool
    
    var body: some View {
        Button{
            animation_count += 1
            if noPortal == false{
                isPresented_Log = true
                
//            @AppStorage("firstTimeLaunch") var checkFirstLaunch: Bool = false
                

            }
        } label:{
            Image(systemName: icon)
        }        
        .font(.title)
        .bold()
        .padding(30)
        .background(.white)
        .fontWeight(.heavy)
        .clipShape(.circle)
        .foregroundStyle(
            LinearGradient(
                colors: [user_color1, user_color2],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .overlay(
            Circle()
                .stroke(LinearGradient(gradient: Gradient(
                    colors: [user_color1.opacity(0.7), user_color1.opacity(0.8)]),
                                       startPoint: .leading,
                                       endPoint: .trailing))
                .scaleEffect(animation_count)
                .opacity(2 - animation_count)
        )
//        .animation(
//            .easeInOut(duration: 1),
//            value: animation_count
//        )
        .shadow(color: .black.opacity(0.2), radius: 20, x:0, y:10)
        .shadow(color: .black.opacity(0.4), radius: 5, x:0, y:2)
        .sheet(isPresented: $isPresented_Log) {
            EnterMealView()
                .presentationDetents([.medium, .large])
        }
    }
}

//struct LogSheetView: View {
//    var body: some View {
//        Text("Log Sheet Content")
//            .font(.largeTitle)
//            .padding()
//    }
//}

#Preview {
    CircleLogButton(user_color1: Color.purple, user_color2: Color.blue, icon: "plus", noPortal: false)
}
