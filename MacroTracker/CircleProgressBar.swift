//
//  CircleProgressBar.swift
//  MacroTracker
//
//  Created by Chris Rowley on 7/26/24.
//

import SwiftUI

struct CircleProgressBar: View {
    let progress: Double
    let calories: Int
    var body: some View {
        ZStack{
            Circle()
                .stroke(
                    Color.purple.opacity(0.5),
                    lineWidth: 30
                )
                        
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(
                    Color.purple,
                    style: StrokeStyle(
                        lineWidth: 30,
                        lineCap: .round
                    )
                )
            
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
            
            Text(String(calories))
                .font(.title)

        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    CircleProgressBar(progress: 0.25, calories: 2500)
}
