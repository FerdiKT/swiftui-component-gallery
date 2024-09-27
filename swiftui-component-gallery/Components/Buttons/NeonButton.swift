import SwiftUI

struct NeonButton: View {
    @State private var isAnimating = false
    
    var body: some View {
        Button(action: {
            print("Neon Button tapped")
        }) {
            Text("NEON")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(
                    ZStack {
                        Capsule()
                            .fill(Color.black)
                        
                        Capsule()
                            .stroke(Color.green, lineWidth: 2)
                            .blur(radius: 4)
                            .opacity(isAnimating ? 0.8 : 0.2)
                            .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: isAnimating)
                        
                        Capsule()
                            .stroke(Color.green, lineWidth: 4)
                            .blur(radius: 8)
                            .opacity(isAnimating ? 0.8 : 0.2)
                            .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true).delay(0.5), value: isAnimating)
                    }
                )
                .shadow(color: Color.green.opacity(0.5), radius: 20, x: 0, y: 0)
        }
        .onAppear {
            isAnimating = true
        }
    }
}