import SwiftUI

struct GlitchButton: View {
    @State private var isGlitching = false
    @State private var offset: CGSize = .zero
    
    var body: some View {
        Button(action: {
            print("Glitch Button tapped")
            triggerGlitch()
        }) {
            Text("Glitch")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 120, height: 50)
                .background(Color.purple)
                .overlay(
                    Text("Glitch")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.cyan)
                        .offset(offset)
                        .opacity(isGlitching ? 0.8 : 0)
                )
                .overlay(
                    Text("Glitch")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.red)
                        .offset(offset.applying(CGAffineTransform(scaleX: -1, y: -1)))
                        .opacity(isGlitching ? 0.8 : 0)
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
    func triggerGlitch() {
        withAnimation(.easeInOut(duration: 0.1).repeatCount(5, autoreverses: true)) {
            isGlitching = true
            offset = CGSize(width: CGFloat.random(in: -5...5), height: CGFloat.random(in: -5...5))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isGlitching = false
            offset = .zero
        }
    }
}