import SwiftUI

struct RotatingButton: View {
    @State private var rotation: Double = 0
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            print("Rotating Button tapped")
            withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5)) {
                rotation += 360
                isPressed.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isPressed = false
            }
        }) {
            Text("Rotate")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 120, height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(LinearGradient(gradient: Gradient(colors: [.purple, .pink]), startPoint: .topLeading, endPoint: .bottomTrailing))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white.opacity(0.5), lineWidth: 2)
                )
                .rotationEffect(.degrees(rotation))
                .scaleEffect(isPressed ? 0.9 : 1)
        }
    }
}