import SwiftUI

struct ConfettiButton: View {
    @State private var isAnimating = false
    @State private var confetti: [ConfettiPiece] = []
    
    var body: some View {
        Button(action: {
            print("Confetti Button tapped")
            generateConfetti()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.pink]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 120, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white.opacity(0.5), lineWidth: 2)
                    )
                
                Text("Confetti")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .bold))
                
                ForEach(confetti) { piece in
                    piece.view
                        .offset(x: piece.x, y: piece.y)
                        .rotationEffect(Angle(degrees: piece.rotation))
                        .opacity(piece.opacity)
                }
            }
            .frame(width: 120, height: 50)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    func generateConfetti() {
        confetti = []
        for _ in 0..<50 {
            confetti.append(ConfettiPiece())
        }
        
        withAnimation(.easeOut(duration: 1)) {
            for i in confetti.indices {
                confetti[i].x = CGFloat.random(in: -60...60)
                confetti[i].y = CGFloat.random(in: -100...0)
                confetti[i].rotation = Double.random(in: 0...360)
                confetti[i].opacity = 0
            }
        }
    }
}

struct ConfettiPiece: Identifiable {
    let id = UUID()
    var x: CGFloat = 0
    var y: CGFloat = 0
    var rotation: Double = 0
    var opacity: Double = 1
    let view: AnyView
    
    init() {
        let shape = Int.random(in: 0...2)
        let color = [Color.red, Color.blue, Color.green, Color.yellow, Color.pink, Color.purple].randomElement()!
        
        switch shape {
        case 0:
            view = AnyView(Rectangle().fill(color).frame(width: 5, height: 5))
        case 1:
            view = AnyView(Circle().fill(color).frame(width: 5, height: 5))
        default:
            view = AnyView(Triangle().fill(color).frame(width: 5, height: 5))
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}