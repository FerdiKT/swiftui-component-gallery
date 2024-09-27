import SwiftUI

struct MorphingButton: View {
    @State private var isAdded = false
    @State private var itemCount = 0
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                isAdded.toggle()
                if isAdded {
                    itemCount += 1
                }
            }
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: isAdded ? 25 : 10)
                    .fill(isAdded ? Color.green : Color.blue)
                    .frame(width: isAdded ? 50 : 150, height: 50)
                
                if isAdded {
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                        .transition(.scale.combined(with: .opacity))
                } else {
                    HStack(spacing: 8) {
                        Image(systemName: "cart")
                            .foregroundColor(.white)
                        Text("Add to Cart")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .semibold))
                    }
                    .transition(.scale.combined(with: .opacity))
                }
            }
        }
        .overlay(
            Text("\(itemCount)")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 24, height: 24)
                .background(Color.red)
                .clipShape(Circle())
                .offset(x: 20, y: -20)
                .opacity(itemCount > 0 ? 1 : 0)
        )
        .animation(.spring(response: 0.4, dampingFraction: 0.6), value: isAdded)
    }
}