import SwiftUI

struct FlippingSquareIndicator: View {
    @State private var isFlipping = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(Color.blue)
            .frame(width: 40, height: 40)
            .rotation3DEffect(
                .degrees(isFlipping ? 360 : 0),
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: isFlipping)
            .onAppear {
                isFlipping = true
            }
    }
}