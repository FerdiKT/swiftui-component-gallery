import SwiftUI

struct DotsIndicator: View {
    @State private var isAnimating = false
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<3) { index in
                Circle()
                    .fill(Color.blue)
                    .frame(width: 20, height: 20)
                    .offset(y: isAnimating ? -10 : 10)
                    .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(Double(index) * 0.2), value: isAnimating)
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}