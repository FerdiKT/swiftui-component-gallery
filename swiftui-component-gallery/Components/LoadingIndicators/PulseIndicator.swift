import SwiftUI

struct PulseIndicator: View {
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        Circle()
            .fill(Color.blue)
            .frame(width: 50, height: 50)
            .scaleEffect(scale)
            .opacity(2 - scale)
            .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: false), value: scale)
            .onAppear {
                scale = 2.0
            }
    }
}