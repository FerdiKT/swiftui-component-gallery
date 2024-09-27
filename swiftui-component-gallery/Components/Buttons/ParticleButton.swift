import SwiftUI

struct ParticleButton: View {
    @State private var isAnimating = false
    @State private var particles: [Particle] = []
    
    var body: some View {
        Button(action: {
            print("Particle Button tapped")
            generateParticles()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 120, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white.opacity(0.5), lineWidth: 2)
                    )
                
                Text("Particle")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .bold))
                
                ForEach(particles) { particle in
                    Circle()
                        .fill(particle.color)
                        .frame(width: particle.size, height: particle.size)
                        .offset(x: particle.x, y: particle.y)
                        .opacity(particle.opacity)
                }
            }
            .frame(width: 120, height: 50)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    func generateParticles() {
        particles = []
        for _ in 0..<20 {
            let particle = Particle(color: [.yellow, .orange, .red].randomElement()!)
            particles.append(particle)
        }
        
        withAnimation(.easeOut(duration: 1)) {
            for i in particles.indices {
                particles[i].x = CGFloat.random(in: -60...60)
                particles[i].y = CGFloat.random(in: -100...100)
                particles[i].opacity = 0
            }
        }
    }
}

struct Particle: Identifiable {
    let id = UUID()
    var x: CGFloat = 0
    var y: CGFloat = 0
    var size: CGFloat = CGFloat.random(in: 5...15)
    var color: Color
    var opacity: Double = 1
}