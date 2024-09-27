import SwiftUI

struct NeumorphicButton: View {
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            print("Neumorphic Button tapped")
            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                isPressed.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                    isPressed = false
                }
            }
        }) {
            Text("Neumorphic")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color.gray.opacity(0.8))
                .frame(width: 150, height: 50)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(#colorLiteral(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)))
                            .shadow(color: Color.white.opacity(0.8), radius: isPressed ? 5 : 10, x: isPressed ? -3 : -10, y: isPressed ? -3 : -10)
                            .shadow(color: Color.black.opacity(0.2), radius: isPressed ? 5 : 10, x: isPressed ? 3 : 10, y: isPressed ? 3 : 10)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(#colorLiteral(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)))
                            .opacity(isPressed ? 1 : 0)
                            .shadow(color: Color.black.opacity(0.2), radius: 3, x: -1, y: -1)
                            .shadow(color: Color.white.opacity(0.8), radius: 3, x: 1, y: 1)
                    }
                )
        }
        .scaleEffect(isPressed ? 0.98 : 1)
    }
}