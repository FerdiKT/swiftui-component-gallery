import SwiftUI

struct ThreeDButton: View {
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            print("3D Button tapped")
            withAnimation(.easeInOut(duration: 0.2)) {
                self.isPressed.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.easeInOut(duration: 0.2)) {
                    self.isPressed = false
                }
            }
        }) {
            Text("3D")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 100, height: 50)
                .background(
                    ZStack {
                        // Bottom layer (shadow)
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue.opacity(0.5))
                            .offset(y: 5)
                            .blur(radius: 4)
                        
                        // Middle layer (side)
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]), startPoint: .top, endPoint: .bottom))
                            .padding(.bottom, 5)
                        
                        // Top layer (face)
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .padding(.bottom, 5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white.opacity(0.5), lineWidth: 1)
                                    .blur(radius: 1)
                                    .padding(.bottom, 5)
                                    .padding(1)
                            )
                    }
                )
                .scaleEffect(isPressed ? 0.95 : 1.0)
                .rotationEffect(isPressed ? .degrees(2) : .degrees(0))
                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
        }
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
    }
}