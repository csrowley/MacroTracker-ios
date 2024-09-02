//
//  ResetLogButton.swift
//  MacroTracker
//
//  Created by Chris Rowley on 8/20/24.
//

import SwiftUI

struct ResetLogButton: View {
    @State private var animation_count = 1.0
    @State private var isPresented_Log = false
    
    let user_color1: Color
    let user_color2: Color
    let instruction: (() -> Void)
    
    var body: some View {
        Button {
            isPresented_Log.toggle()
            animation_count += 1

        } label: {
            Image(systemName: "trash.fill")
        }
//        .symbolEffect(.bounce, value: animation_count)
        
        
        .font(.title)
        .bold()
        .padding(10)
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
        .alert(isPresented: $isPresented_Log){
            Alert(
                title: Text("⚠️ Warning!"),
                message: Text("Pressing this will reset your daily calorie progress. Are you sure to continue?"),
                primaryButton: .destructive(Text("Yes"), action: {instruction()}),
                secondaryButton: .cancel())
        }

    }
}

#Preview {
    ResetLogButton(user_color1: Color.purple, user_color2: Color.blue, instruction: {print("h")})
}
