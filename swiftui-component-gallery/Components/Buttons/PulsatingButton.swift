import SwiftUI

struct PulsatingButton: View {
    @State private var isPulsating = false
    
    var body: some View {
        Button(action: {
            print("Pulsating Button tapped")
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.red.opacity(0.3))
                    .frame(width: 120, height: 60)
                    .scaleEffect(isPulsating ? 1.2 : 1.0)
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: isPulsating)
                
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.red.opacity(0.5))
                    .frame(width: 110, height: 50)
                    .scaleEffect(isPulsating ? 1.1 : 1.0)
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true).delay(0.2), value: isPulsating)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.red)
                    .frame(width: 100, height: 40)
                
                Text("Pulse")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .frame(width: 120, height: 60)
        .onAppear {
            isPulsating = true
        }
    }
}