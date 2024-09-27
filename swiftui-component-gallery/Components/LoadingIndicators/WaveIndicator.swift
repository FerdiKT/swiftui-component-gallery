import SwiftUI

struct WaveIndicator: View {
    @State private var waveOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            ForEach(0..<3) { i in
                SineWave(frequency: 10, amplitude: 10)
                    .stroke(Color.blue.opacity(0.8 - Double(i) * 0.2), lineWidth: 3)
                    .offset(x: waveOffset + CGFloat(i) * 10)
            }
        }
        .frame(width: 100, height: 50)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .onAppear {
            withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                waveOffset = -40
            }
        }
    }
}

struct SineWave: Shape {
    var frequency: Double
    var amplitude: Double
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()
        let width = Double(rect.width)
        let height = Double(rect.height)
        let midHeight = height / 2
        
        path.move(to: CGPoint(x: 0, y: midHeight))
        
        for x in stride(from: 0, through: width, by: 1) {
            let relativeX = x / width
            let y = sin(relativeX * .pi * frequency) * amplitude + midHeight
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        return Path(path.cgPath)
    }
}