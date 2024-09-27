import SwiftUI

struct OrbitIndicator: View {
    @State private var isOrbiting = false
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.blue.opacity(0.3), lineWidth: 4)
                .frame(width: 60, height: 60)
            
            Circle()
                .fill(Color.blue)
                .frame(width: 12, height: 12)
                .offset(y: -30)
                .rotationEffect(.degrees(isOrbiting ? 360 : 0))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: isOrbiting)
        }
        .onAppear {
            isOrbiting = true
        }
    }
}