import SwiftUI

struct LiquidDropletIndicator: View {
    @State private var animationPhase: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            
            ZStack {
                // Base droplet shape
                Circle()
                    .fill(Color.blue.opacity(0.3))
                    .frame(width: size, height: size)
                
                // Animated liquid surface
                LiquidSurface(phase: animationPhase)
                    .fill(Color.blue)
                    .frame(width: size, height: size)
                    .mask(
                        Circle()
                            .frame(width: size, height: size)
                    )
                
                // Highlight
                Circle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: size * 0.15, height: size * 0.15)
                    .offset(x: -size * 0.2, y: -size * 0.2)
            }
            .frame(width: size, height: size)
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            withAnimation(Animation.linear(duration: 4).repeatForever(autoreverses: false)) {
                animationPhase = 2 * .pi
            }
        }
    }
}

struct LiquidSurface: Shape {
    var phase: CGFloat
    
    var animatableData: CGFloat {
        get { phase }
        set { phase = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        
        return Path { path in
            path.move(to: CGPoint(x: 0, y: height * 0.5))
            
            for x in stride(from: 0, through: width, by: 1) {
                let relativeX = x / width
                let wave1 = sin(relativeX * 4 * .pi + phase)
                let wave2 = sin(relativeX * 8 * .pi - phase)
                let combinedWave = (wave1 + wave2) / 2
                
                let y = height * (0.5 + 0.04 * combinedWave)  // Changed from 0.03 to 0.04
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
            path.addLine(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: 0, y: height))
            path.closeSubpath()
        }
    }
}

struct LiquidDropletIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LiquidDropletIndicator()
            .frame(width: 100, height: 100)
    }
}