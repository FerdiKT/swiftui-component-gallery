import SwiftUI

struct GeometricMorphingIndicator: View {
    @State private var morphPhase: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<3) { shapeIndex in
                    MorphingShape(phase: morphPhase, shapeIndex: shapeIndex)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [.blue, .purple, .pink]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 3
                        )
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .opacity(0.5)
                }
            }
        }
        .frame(width: 100, height: 100)
        .onAppear {
            withAnimation(Animation.linear(duration: 6).repeatForever(autoreverses: false)) {
                morphPhase = 3
            }
        }
    }
}

struct MorphingShape: Shape {
    var phase: CGFloat
    var shapeIndex: Int
    
    var animatableData: CGFloat {
        get { phase }
        set { phase = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2 * 0.8
        
        return Path { path in
            let points = self.calculatePoints(center: center, radius: radius, phase: phase, shapeIndex: shapeIndex)
            
            path.move(to: points[0])
            for point in points.dropFirst() {
                path.addLine(to: point)
            }
            path.closeSubpath()
        }
    }
    
    private func calculatePoints(center: CGPoint, radius: CGFloat, phase: CGFloat, shapeIndex: Int) -> [CGPoint] {
        let baseAngle = 2 * .pi / 3 * CGFloat(shapeIndex)
        let currentShape = Int(phase) % 3
        let nextShape = (currentShape + 1) % 3
        let subPhase = phase - CGFloat(Int(phase))
        
        let currentPoints = getShapePoints(shape: currentShape, center: center, radius: radius, baseAngle: baseAngle)
        let nextPoints = getShapePoints(shape: nextShape, center: center, radius: radius, baseAngle: baseAngle)
        
        return zip(currentPoints, nextPoints).map { current, next in
            let x = current.x + (next.x - current.x) * subPhase
            let y = current.y + (next.y - current.y) * subPhase
            return CGPoint(x: x, y: y)
        }
    }
    
    private func getShapePoints(shape: Int, center: CGPoint, radius: CGFloat, baseAngle: CGFloat) -> [CGPoint] {
        switch shape {
        case 0: // Triangle
            return (0..<3).map { i in
                let angle = baseAngle + CGFloat(i) * 2 * .pi / 3
                return CGPoint(
                    x: center.x + cos(angle) * radius,
                    y: center.y + sin(angle) * radius
                )
            }
        case 1: // Square
            return (0..<4).map { i in
                let angle = baseAngle + CGFloat(i) * .pi / 2
                return CGPoint(
                    x: center.x + cos(angle) * radius,
                    y: center.y + sin(angle) * radius
                )
            }
        case 2: // Pentagon
            return (0..<5).map { i in
                let angle = baseAngle + CGFloat(i) * 2 * .pi / 5
                return CGPoint(
                    x: center.x + cos(angle) * radius,
                    y: center.y + sin(angle) * radius
                )
            }
        default:
            return []
        }
    }
}

struct GeometricMorphingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        GeometricMorphingIndicator()
    }
}