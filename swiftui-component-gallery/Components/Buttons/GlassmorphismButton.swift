import SwiftUI

struct GlassmorphismButton: View {
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            print("Glassmorphism Button tapped")
            withAnimation(.easeInOut(duration: 0.2)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isPressed = false
                }
            }
        }) {
            Text("Glass")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: 120, height: 50)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white.opacity(0.2))
                        
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white.opacity(0.5), lineWidth: 2)
                        
                        // Shine effect
                        RoundedRectangle(cornerRadius: 15)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(stops: [
                                        .init(color: .white.opacity(0.5), location: 0),
                                        .init(color: .clear, location: 0.3)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    }
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        .blur(radius: 1)
                )
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                .scaleEffect(isPressed ? 0.95 : 1)
        }
        .buttonStyle(PlainButtonStyle())
        .background(
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .purple, .pink]), startPoint: .topLeading, endPoint: .bottomTrailing)
                
                // Animated circles
                ForEach(0..<3) { i in
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .blur(radius: 20)
                        .offset(
                            x: CGFloat.random(in: -100...100),
                            y: CGFloat.random(in: -100...100)
                        )
                        .frame(width: CGFloat.random(in: 50...100), height: CGFloat.random(in: 50...100))
                        .animation(
                            Animation.easeInOut(duration: Double.random(in: 5...10))
                                .repeatForever(autoreverses: true)
                                .delay(Double.random(in: 0...5)),
                            value: UUID()
                        )
                }
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .frame(width: 150, height: 80)
    }
}