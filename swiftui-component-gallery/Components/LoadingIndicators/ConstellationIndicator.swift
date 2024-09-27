import SwiftUI

struct ConstellationIndicator: View {
    @State private var phase = 0.0
    
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                let timeInterval = timeline.date.timeIntervalSinceReferenceDate
                let phase = timeInterval.remainder(dividingBy: 4)
                
                for i in 0..<5 {
                    let angle = Double(i) * .pi * 0.4 + phase * .pi * 0.5
                    let x = cos(angle) * size.width / 3 + size.width / 2
                    let y = sin(angle) * size.height / 3 + size.height / 2
                    
                    let opacity = (sin(phase + Double(i)) / 2 + 0.5)
                    
                    context.opacity = opacity
                    context.fill(Path(ellipseIn: CGRect(x: x - 3, y: y - 3, width: 6, height: 6)), with: .color(.yellow))
                }
                
                context.stroke(
                    Path { path in
                        for i in 0..<5 {
                            let angle = Double(i) * .pi * 0.4 + phase * .pi * 0.5
                            let x = cos(angle) * size.width / 3 + size.width / 2
                            let y = sin(angle) * size.height / 3 + size.height / 2
                            
                            if i == 0 {
                                path.move(to: CGPoint(x: x, y: y))
                            } else {
                                path.addLine(to: CGPoint(x: x, y: y))
                            }
                        }
                        path.closeSubpath()
                    },
                    with: .color(.yellow.opacity(0.5)),
                    lineWidth: 1
                )
            }
        }
        .frame(width: 100, height: 100)
    }
}