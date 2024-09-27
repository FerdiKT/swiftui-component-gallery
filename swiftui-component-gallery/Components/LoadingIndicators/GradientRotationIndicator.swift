import SwiftUI

struct GradientRotationIndicator: View {
    @State private var rotation: Double = 0
    
    var body: some View {
        Circle()
            .fill(AngularGradient(gradient: Gradient(colors: [.blue, .purple, .blue]), center: .center))
            .frame(width: 50, height: 50)
            .rotationEffect(Angle(degrees: rotation))
            .onAppear {
                withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                    rotation = 360
                }
            }
    }
}