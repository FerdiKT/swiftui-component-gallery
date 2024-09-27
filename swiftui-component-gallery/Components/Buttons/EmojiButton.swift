import SwiftUI

struct EmojiButton: View {
    var body: some View {
        Button(action: {}) {
            Text("🚀 Blast Off!")
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(20)
                .font(.headline)
        }
    }
}