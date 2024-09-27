import SwiftUI

struct ButtonComponents: View {
    @State private var selectedButton: String?
    @Namespace private var animation
    
    let buttons: [(String, AnyView, AnyView)] = [
        ("Gradient", AnyView(GradientButton()), AnyView(Color.clear)),
        ("Neon", AnyView(NeonButton()), AnyView(Color.black)),
        ("3D", AnyView(ThreeDButton()), AnyView(Color.blue.opacity(0.1))),
        ("Animated", AnyView(AnimatedLoadingButton()), AnyView(Color.green.opacity(0.1))),
        ("Emoji", AnyView(EmojiButton()), AnyView(Color.orange.opacity(0.1))),
        ("Glass", AnyView(GlassmorphismButton()), AnyView(
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .purple, .pink]), startPoint: .topLeading, endPoint: .bottomTrailing)
                ForEach(0..<3) { _ in
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .blur(radius: 20)
                        .frame(width: 100, height: 100)
                        .offset(x: CGFloat.random(in: -50...50), y: CGFloat.random(in: -50...50))
                }
            }
        )),
        ("Neumorphic", AnyView(NeumorphicButton()), AnyView(Color(#colorLiteral(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)))),
        ("Pulsating", AnyView(PulsatingButton()), AnyView(Color.red.opacity(0.1))),
        ("Skeuomorphic", AnyView(SkeuomorphicButton()), AnyView(Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)))),
        ("Add to Cart", AnyView(MorphingButton()), AnyView(Color.white)),
        ("Shimmering", AnyView(ShimmeringButton()), AnyView(Color.blue.opacity(0.1))),
        ("Bouncing", AnyView(BouncingButton()), AnyView(Color.green.opacity(0.1))),
        ("Ripple", AnyView(RippleButton()), AnyView(Color.blue.opacity(0.1))),
        ("Rotating", AnyView(RotatingButton()), AnyView(Color.purple.opacity(0.1))),
        ("Glitch", AnyView(GlitchButton()), AnyView(Color.purple.opacity(0.1))),
        ("Floating", AnyView(FloatingButton()), AnyView(Color.blue.opacity(0.1))),
        ("Water Tracker", AnyView(LiquidButton()), AnyView(Color.blue.opacity(0.1))),
        ("Particle", AnyView(ParticleButton()), AnyView(Color.orange.opacity(0.1))),
        ("Confetti", AnyView(ConfettiButton()), AnyView(Color.purple.opacity(0.1))),
        ("Magnetic", AnyView(MagneticButton()), AnyView(Color.blue.opacity(0.1)))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                ForEach(buttons, id: \.0) { title, button, background in
                    ButtonCard(title: title, button: button, background: background, isSelected: title == selectedButton, namespace: animation)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                selectedButton = (selectedButton == title) ? nil : title
                            }
                        }
                }
            }
            .padding()
        }
        .navigationTitle("Button Gallery")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ButtonCard: View {
    let title: String
    let button: AnyView
    let background: AnyView
    let isSelected: Bool
    let namespace: Namespace.ID
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.top)
            
            button
                .frame(height: isSelected ? 100 : 60)
                .padding()
        }
        .frame(maxWidth: .infinity)
        .background(background)
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.primary.opacity(0.2), lineWidth: 1)
        )
        .shadow(color: Color.primary.opacity(0.1), radius: 5, x: 0, y: 2)
        .matchedGeometryEffect(id: title, in: namespace)
        .animation(.spring(), value: isSelected)
    }
}

#Preview {
    NavigationView {
        ButtonComponents()
    }
}