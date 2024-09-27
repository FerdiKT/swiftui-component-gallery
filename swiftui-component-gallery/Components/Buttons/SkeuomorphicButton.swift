import SwiftUI

struct SkeuomorphicButton: View {
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            print("Skeuomorphic Button tapped")
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 0.1)) {
                    isPressed = false
                }
            }
        }) {
            Text("Skeuomorphic")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 150, height: 50)
                .background(
                    ZStack {
                        // Base layer
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)), Color(#colorLiteral(red: 0.3, green: 0.3, blue: 0.3, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                        
                        // Highlight layer
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.6), Color.white.opacity(0.2), Color.white.opacity(0)]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2)
                            .padding(1)
                        
                        // Inner shadow
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black.opacity(0.5), lineWidth: 4)
                            .blur(radius: 4)
                            .offset(x: 0, y: 2)
                            .mask(RoundedRectangle(cornerRadius: 10).fill(LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .top, endPoint: .bottom)))
                        
                        // Button face
                        RoundedRectangle(cornerRadius: 8)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)), Color(#colorLiteral(red: 0.3, green: 0.3, blue: 0.3, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .padding(4)
                            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: isPressed ? 0 : 2)
                            .offset(y: isPressed ? 2 : 0)
                    }
                )
        }
        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
    }
}