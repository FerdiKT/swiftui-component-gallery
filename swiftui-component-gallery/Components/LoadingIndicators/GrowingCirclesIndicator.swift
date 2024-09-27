import SwiftUI

struct GrowingCirclesIndicator: View {
    @State private var isAnimating = false
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<3) { index in
                Circle()
                    .fill(Color.blue)
                    .frame(width: 20, height: 20)
                    .scaleEffect(isAnimating ? 1 : 0.5)
                    .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(Double(index) * 0.2), value: isAnimating)
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}