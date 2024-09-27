import SwiftUI

struct BouncingButton: View {
    @State private var isBouncing = false
    @State private var bounceCount = 0
    
    var body: some View {
        Button(action: {
            print("Bouncing Button tapped")
            bounce()
        }) {
            Text("Bounce")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 120, height: 50)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.green, Color.green.opacity(0.7)]), startPoint: .top, endPoint: .bottom))
                        
                        // Add a subtle inner shadow
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black.opacity(0.1), lineWidth: 4)
                            .blur(radius: 4)
                            .offset(x: 2, y: 2)
                            .mask(RoundedRectangle(cornerRadius: 10).fill(LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .top, endPoint: .bottom)))
                    }
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white.opacity(0.5), lineWidth: 2)
                )
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                .scaleEffect(isBouncing ? 1.1 : 1.0)
                .offset(y: isBouncing ? -5 : 0)
        }
        .overlay(
            Circle()
                .fill(Color.yellow)
                .frame(width: 20, height: 20)
                .offset(x: 50, y: isBouncing ? 30 : -25)
                .opacity(bounceCount > 0 ? 1 : 0)
        )
    }
    
    private func bounce() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.3)) {
            isBouncing = true
            bounceCount += 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.3)) {
                isBouncing = false
            }
        }
        
        // Reset bounce count after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            bounceCount = 0
        }
    }
}