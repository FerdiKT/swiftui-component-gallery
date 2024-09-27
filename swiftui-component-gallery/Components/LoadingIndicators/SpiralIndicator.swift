import SwiftUI

struct SpiralIndicator: View {
    @State private var isAnimating = false
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<8) { index in
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 8, height: 8)
                    .offset(y: geometry.size.height / 2 - 4)
                    .rotationEffect(.degrees(Double(index) * 45))
                    .scaleEffect(isAnimating ? 0 : 1)
                    .opacity(isAnimating ? 0 : 1)
                    .animation(
                        Animation.easeInOut(duration: 1)
                            .repeatForever(autoreverses: false)
                            .delay(0.1 * Double(index)),
                        value: isAnimating
                    )
            }
        }
        .frame(width: 50, height: 50)
        .onAppear {
            isAnimating = true
        }
    }
}