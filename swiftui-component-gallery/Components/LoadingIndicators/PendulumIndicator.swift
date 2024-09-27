import SwiftUI

struct PendulumIndicator: View {
    @State private var angle: Double = -45

    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 2)
                    .frame(width: size, height: size)
                
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 2, height: size / 2)
                    .offset(y: size / 4)
                    .rotationEffect(.degrees(angle))
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: angle)
                
                Circle()
                    .fill(Color.blue)
                    .frame(width: size / 8, height: size / 8)
                    .offset(y: size / 2 - size / 16)
                    .rotationEffect(.degrees(angle))
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: angle)
            }
            .frame(width: size, height: size)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            .onAppear {
                angle = 45
            }
        }
    }
}

struct PendulumIndicator_Previews: PreviewProvider {
    static var previews: some View {
        PendulumIndicator()
            .frame(width: 200, height: 200)
    }
}