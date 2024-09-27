import SwiftUI

struct DNAHelixIndicator: View {
    @State private var phase: CGFloat = 0
    let timer = Timer.publish(every: 0.016, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Canvas { context, size in
            drawDNAHelix(context: context, size: size)
        }
        .frame(width: 50, height: 100)
        .onReceive(timer) { _ in
            phase += 0.01
            if phase > 1 {
                phase -= 1
            }
        }
    }
    
    private func drawDNAHelix(context: GraphicsContext, size: CGSize) {
        for i in 0..<20 {
            let progress = CGFloat(i) / 19
            let yOffset = progress * size.height
            
            drawStrand(context: context, size: size, progress: progress, yOffset: yOffset, isLeft: true)
            drawStrand(context: context, size: size, progress: progress, yOffset: yOffset, isLeft: false)
            
            if i < 19 {
                drawConnectingLines(context: context, size: size, progress: progress, yOffset: yOffset, nextProgress: CGFloat(i + 1) / 19)
            }
        }
    }
    
    private func drawStrand(context: GraphicsContext, size: CGSize, progress: CGFloat, yOffset: CGFloat, isLeft: Bool) {
        let xOffset = size.width / 2 + (isLeft ? 1 : -1) * sin(progress * .pi * 2 + phase * .pi * 2) * size.width / 4
        let color = isLeft ? Color.blue : Color.purple
        context.fill(Path(ellipseIn: CGRect(x: xOffset - 4, y: yOffset - 4, width: 8, height: 8)), with: .color(color.opacity(progress)))
    }
    
    private func drawConnectingLines(context: GraphicsContext, size: CGSize, progress: CGFloat, yOffset: CGFloat, nextProgress: CGFloat) {
        let nextYOffset = nextProgress * size.height
        
        drawLine(context: context, size: size, progress: progress, yOffset: yOffset, nextProgress: nextProgress, nextYOffset: nextYOffset, isLeft: true)
        drawLine(context: context, size: size, progress: progress, yOffset: yOffset, nextProgress: nextProgress, nextYOffset: nextYOffset, isLeft: false)
    }
    
    private func drawLine(context: GraphicsContext, size: CGSize, progress: CGFloat, yOffset: CGFloat, nextProgress: CGFloat, nextYOffset: CGFloat, isLeft: Bool) {
        let xOffset = size.width / 2 + (isLeft ? 1 : -1) * sin(progress * .pi * 2 + phase * .pi * 2) * size.width / 4
        let nextXOffset = size.width / 2 + (isLeft ? 1 : -1) * sin(nextProgress * .pi * 2 + phase * .pi * 2) * size.width / 4
        let color = isLeft ? Color.blue : Color.purple
        
        context.stroke(
            Path { path in
                path.move(to: CGPoint(x: xOffset, y: yOffset))
                path.addLine(to: CGPoint(x: nextXOffset, y: nextYOffset))
            },
            with: .color(color.opacity((progress + nextProgress) / 2)),
            lineWidth: 2
        )
    }
}