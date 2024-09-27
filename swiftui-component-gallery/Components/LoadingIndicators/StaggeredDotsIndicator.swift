import SwiftUI

struct StaggeredDotsIndicator: View {
    @State private var isAnimating = false
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(0..<5) { index in
                Circle()
                    .fill(Color.blue)
                    .frame(width: 10, height: 10)
                    .offset(y: isAnimating ? -10 : 10)
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