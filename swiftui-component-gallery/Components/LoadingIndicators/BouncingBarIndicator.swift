import SwiftUI

struct BouncingBarIndicator: View {
    @State private var isAnimating = false
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<5) { index in
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color.blue)
                    .frame(width: 6, height: 36)
                    .scaleEffect(y: isAnimating ? 0.4 : 1)
                    .animation(
                        Animation.easeInOut(duration: 0.5)
                            .repeatForever()
                            .delay(0.1 * Double(index)),
                        value: isAnimating
                    )
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}