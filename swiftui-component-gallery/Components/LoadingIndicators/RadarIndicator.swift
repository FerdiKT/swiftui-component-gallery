import SwiftUI

struct RadarIndicator: View {
    @State private var isAnimating = false
    @State private var dots: [(CGPoint, Double)] = []
    
    let dotCount = 10
    let radarRadius: CGFloat = 30
    let lineCount = 4
    
    var body: some View {
        ZStack {
            // Background circle
            Circle()
                .stroke(Color.green.opacity(0.3), lineWidth: 2)
                .frame(width: radarRadius * 2, height: radarRadius * 2)
            
            // Radar lines
            ForEach(0..<lineCount, id: \.self) { index in
                RadarLine()
                    .stroke(Color.green.opacity(0.5), lineWidth: 1)
                    .frame(width: radarRadius * 2, height: radarRadius * 2)
                    .rotationEffect(Angle(degrees: Double(index) * (360 / Double(lineCount))))
            }
            
            // Radar sweep line
            RadarSweepLine()
                .stroke(Color.green, lineWidth: 2)
                .frame(width: radarRadius * 2, height: radarRadius * 2)
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                .animation(Animation.linear(duration: 4).repeatForever(autoreverses: false), value: isAnimating)
            
            // Random dots
            ForEach(0..<dots.count, id: \.self) { index in
                Circle()
                    .fill(Color.green)
                    .frame(width: 4, height: 4)
                    .position(dots[index].0)
                    .opacity(dots[index].1)
            }
        }
        .frame(width: radarRadius * 2, height: radarRadius * 2)
        .onAppear {
            isAnimating = true
            generateRandomDots()
        }
        .onReceive(Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()) { _ in
            updateDotOpacities()
        }
    }
    
    private func generateRandomDots() {
        dots = (0..<dotCount).map { _ in
            let angle = Double.random(in: 0..<2 * .pi)
            let distance = CGFloat.random(in: 0...(radarRadius - 2))
            let x = cos(angle) * distance
            let y = sin(angle) * distance
            return (CGPoint(x: x + radarRadius, y: y + radarRadius), 0.0)
        }
    }
    
    private func updateDotOpacities() {
        let currentAngle = isAnimating ? (Date().timeIntervalSinceReferenceDate.truncatingRemainder(dividingBy: 4) / 4) * 360 : 0
        
        for i in 0..<dots.count {
            let dotAngle = atan2(dots[i].0.y - radarRadius, dots[i].0.x - radarRadius) * 180 / .pi
            let normalizedDotAngle = (dotAngle + 360).truncatingRemainder(dividingBy: 360)
            let angleDifference = (currentAngle - normalizedDotAngle + 360).truncatingRemainder(dividingBy: 360)
            
            if angleDifference < 10 {
                dots[i].1 = 1.0
            } else {
                dots[i].1 = max(0, dots[i].1 - 0.1)
            }
        }
    }
}

struct RadarSweepLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}

struct RadarLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}