import SwiftUI

struct LoadingIndicatorComponents: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                LoadingIndicatorCard(title: "Spinner", content: SpinnerIndicator())
                LoadingIndicatorCard(title: "Pulse", content: PulseIndicator())
                LoadingIndicatorCard(title: "Growing Circles", content: GrowingCirclesIndicator())
                LoadingIndicatorCard(title: "Dots", content: DotsIndicator())
                LoadingIndicatorCard(title: "Circular Progress", content: CircularProgressIndicator())
                LoadingIndicatorCard(title: "Wave", content: WaveIndicator())
                LoadingIndicatorCard(title: "Gradient Rotation", content: GradientRotationIndicator())
                LoadingIndicatorCard(title: "Bouncing Bar", content: BouncingBarIndicator())
                LoadingIndicatorCard(title: "Flipping Square", content: FlippingSquareIndicator())
                LoadingIndicatorCard(title: "Orbit", content: OrbitIndicator())
                LoadingIndicatorCard(title: "Typing", content: TypingIndicator())
                LoadingIndicatorCard(title: "Spiral", content: SpiralIndicator())
                LoadingIndicatorCard(title: "Staggered Dots", content: StaggeredDotsIndicator())
                LoadingIndicatorCard(title: "Infinity", content: InfinityLoader())
                LoadingIndicatorCard(title: "Radar", content: RadarIndicator())
                LoadingIndicatorCard(title: "DNA Helix", content: DNAHelixIndicator())
                LoadingIndicatorCard(title: "Constellation", content: ConstellationIndicator())
                LoadingIndicatorCard(title: "Liquid Droplet", content: LiquidDropletIndicator())
                LoadingIndicatorCard(title: "Geometric Morphing", content: GeometricMorphingIndicator())
                LoadingIndicatorCard(title: "Pendulum", content: PendulumIndicator())
            }
            .padding()
        }
        .navigationTitle("Loading Indicators")
    }
}

struct LoadingIndicatorCard<Content: View>: View {
    let title: String
    let content: Content
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .padding(.bottom, 5)
            
            content
                .frame(height: 100)
        }
        .frame(height: 150)
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: Color.primary.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct LoadingIndicatorComponents_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicatorComponents()
    }
}