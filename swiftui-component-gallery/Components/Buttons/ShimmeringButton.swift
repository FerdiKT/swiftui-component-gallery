import SwiftUI

struct ShimmeringButton: View {
    @State private var shimmerOffset: CGFloat = -0.25

    var body: some View {
        Button(action: {
            print("Shimmering Button tapped")
        }) {
            Text("Shimmer")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 120, height: 50)
                .background(
                    ZStack {
                        Color.blue
                        Color.white.opacity(0.2)
                            .blur(radius: 10)
                            .offset(x: -100 + (shimmerOffset * 300))
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white.opacity(0.5), lineWidth: 2)
                )
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                shimmerOffset = 1.25
            }
        }
    }
}