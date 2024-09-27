import SwiftUI

struct AnimatedLoadingButton: View {
    @State private var isLoading = false
    
    var body: some View {
        Button(action: { isLoading.toggle() }) {
            HStack {
                Text("Loading Button")
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                }
            }
            .padding()
            .background(isLoading ? Color.gray : Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}