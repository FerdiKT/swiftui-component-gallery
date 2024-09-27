import SwiftUI

struct CircularProgressIndicator: View {
    @State private var progress: CGFloat = 0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 8)
                .opacity(0.3)
                .foregroundColor(.blue)
            
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                .foregroundColor(.blue)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear(duration: 1), value: progress)
        }
        .frame(width: 50, height: 50)
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                progress += 0.1
                if progress >= 1.0 {
                    progress = 0.0
                }
            }
        }
    }
}