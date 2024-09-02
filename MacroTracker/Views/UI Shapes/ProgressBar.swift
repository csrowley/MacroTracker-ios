import SwiftUI

struct ProgressBar: View {
    let progress: Double
    let macros: Int
    let user_color: Color
    
    var body: some View {
        ZStack(alignment: .leading) {
            // Background
            RoundedRectangle(cornerRadius: 10)
                .fill(user_color.opacity(0.5))
                .stroke(Color.black.opacity(0.8))
                .frame(height: 20)
            
            // Foreground (Progress)
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 10)
                    .fill(user_color)
                    .frame(width: CGFloat(min(max(progress, 0), 1)) * geometry.size.width, height: 20)
            }
            .frame(height: 20) // Make sure to set the height here
            .animation(.easeOut, value: progress)
            
            // Text in the center
            HStack {
                Spacer()
                Text(String(macros) + "g")
                    .foregroundColor(.white)
                    .bold()
                Spacer()
            }
        }
        .frame(width: 300, height: 20)
    }
}

#Preview {
    ProgressBar(progress: 0.8, macros: 2500, user_color: Color.pink)
}
