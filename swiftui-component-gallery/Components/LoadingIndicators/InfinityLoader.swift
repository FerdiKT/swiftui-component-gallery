import SwiftUI

struct InfinityLoader: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.blue.opacity(0.3), lineWidth: 5)
                .frame(width: 50, height: 50)
            
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(Color.blue, lineWidth: 5)
                .frame(width: 50, height: 50)
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: isAnimating)
        }
        .onAppear {
            isAnimating = true
        }
    }
}