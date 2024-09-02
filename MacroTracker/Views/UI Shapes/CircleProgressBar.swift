//
//  CircleProgressBar.swift
//  MacroTracker
//
//  Created by Chris Rowley on 7/26/24.
//

import SwiftUI

struct CircleProgressBar: View {
    var progress: Double
    var calories: Int
    let user_color: Color
    var body: some View {
        ZStack{
            Circle()
                .stroke(
                    Color(user_color.opacity(0.5)),
                    lineWidth: 30
                )
                        
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(
                    Color(user_color),
                    style: StrokeStyle(
                        lineWidth: 30,
                        lineCap: .round
                    )
                )
            
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
            
            Text(String(calories))
                .font(Font.custom("Montserrat-Bold", size: 35)) // Set your custom font and size


        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    CircleProgressBar(progress: 0.25, calories: 2500, user_color: Color.purple)
}
