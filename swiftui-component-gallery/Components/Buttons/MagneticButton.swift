import SwiftUI

struct MagneticButton: View {
    @State private var offset: CGSize = .zero
    @State private var isDragging = false
    
    var body: some View {
        ZStack {
            Circle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.cyan]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 60, height: 60)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                .offset(offset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            isDragging = true
                            offset = value.translation
                        }
                        .onEnded { _ in
                            isDragging = false
                            withAnimation(.spring()) {
                                offset = .zero
                            }
                        }
                )
                .animation(isDragging ? nil : .spring(), value: offset)
            
            Image(systemName: "magnet.fill")
                .foregroundColor(.white)
                .font(.system(size: 24))
                .offset(offset)
                .animation(isDragging ? nil : .spring(), value: offset)
        }
        .frame(width: 120, height: 120)
        .overlay(
            Text("Drag me")
                .font(.caption)
                .foregroundColor(.secondary)
                .offset(y: 40)
        )
    }
}