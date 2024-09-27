import SwiftUI

struct LiquidButton: View {
    @State private var fillAmount: CGFloat = 0
    @State private var isAnimating = false
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                fillAmount = fillAmount < 1.0 ? fillAmount + 0.25 : 0
            }
            isAnimating = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isAnimating = false
            }
        }) {
            ZStack {
                // Glass container
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.blue.opacity(0.2))
                    .frame(width: 120, height: 60)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.blue, lineWidth: 2)
                    )
                
                // Water fill
                WaterWave(progress: fillAmount, waveHeight: 5, offset: isAnimating ? 0.5 : 0)
                    .fill(Color.blue)
                    .frame(width: 120, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                // Water drops
                ForEach(0..<3) { i in
                    Circle()
                        .fill(Color.blue.opacity(0.5))
                        .frame(width: 6, height: 6)
                        .offset(x: CGFloat(i * 15) - 15, y: isAnimating ? 25 : -25)
                        .opacity(isAnimating ? 0 : 1)
                        .animation(Animation.easeInOut(duration: 0.5).delay(Double(i) * 0.1), value: isAnimating)
                }
                
                // Text
                VStack(spacing: 2) {
                    Text("Add Water")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.blue)
                    Text("\(Int(fillAmount * 200)) ml")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.blue)
                }
            }
        }
        .frame(width: 120, height: 60)
    }
}

struct WaterWave: Shape {
    var progress: CGFloat
    var waveHeight: CGFloat
    var offset: CGFloat
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(progress, offset) }
        set {
            progress = newValue.first
            offset = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let progressHeight = (1 - progress) * rect.height
        let waveWidth = rect.width
        
        path.move(to: CGPoint(x: 0, y: rect.height))
        
        for x in stride(from: 0, through: waveWidth, by: 1) {
            let relativeX = x / waveWidth
            let sine = sin(relativeX * .pi * 2 + offset * .pi * 2)
            let y = progressHeight + sine * waveHeight
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.closeSubpath()
        
        return path
    }
}