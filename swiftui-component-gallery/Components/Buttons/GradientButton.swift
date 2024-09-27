import SwiftUI

struct GradientButton: View {
    var body: some View {
        Button(action: {
            print("Gradient Button tapped")
        }) {
            Text("Gradient")
                .font(.system(size: 18, weight: .semibold))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.blue, .purple, .pink]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}