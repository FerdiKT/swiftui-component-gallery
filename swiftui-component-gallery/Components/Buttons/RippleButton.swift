import SwiftUI

struct RippleButton: View {
    @State private var isRippling = false
    @State private var rippleSize: CGFloat = 0
    @State private var rippleOpacity: Double = 0
    
    var body: some View {
        Button(action: {
            print("Ripple Button tapped")
            startRippleAnimation()
        }) {
            ZStack {
                Text("Ripple")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 120, height: 50)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Circle()
                    .fill(Color.white.opacity(0.3))
                    .frame(width: rippleSize, height: rippleSize)
                    .scaleEffect(isRippling ? 1 : 0)
                    .opacity(rippleOpacity)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
    private func startRippleAnimation() {
        rippleSize = 0
        rippleOpacity = 0.5
        isRippling = true
        
        withAnimation(.easeOut(duration: 0.5)) {
            rippleSize = 150
            rippleOpacity = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isRippling = false
        }
    }
}