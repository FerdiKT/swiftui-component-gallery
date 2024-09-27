import SwiftUI

struct FloatingButton: View {
    @State private var isFloating = false
    
    var body: some View {
        Button(action: {
            print("Floating Button tapped")
        }) {
            Text("Float")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 120, height: 50)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white.opacity(0.5), lineWidth: 2)
                )
        }
        .offset(y: isFloating ? -5 : 0)
        .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: isFloating)
        .onAppear {
            isFloating = true
        }
    }
}