//
//  ContentView.swift
//  swiftui-component-gallery
//
//  Created by Ferdi Kiziltoprak on 26.09.2024.
//

import SwiftUI

struct ComponentCategory: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
}

struct ContentView: View {
    let categories = [
        ComponentCategory(name: "Buttons", icon: "rectangle.and.hand.point.up.left.filled"),
        ComponentCategory(name: "Loading Indicators", icon: "circle.dotted"),
        ComponentCategory(name: "Text Fields", icon: "textformat"),
        ComponentCategory(name: "Toggles", icon: "switch.2"),
        ComponentCategory(name: "Sliders", icon: "slider.horizontal.3"),
        ComponentCategory(name: "Progress Bars", icon: "chart.bar.fill"),
        ComponentCategory(name: "Cards", icon: "rectangle.on.rectangle"),
        ComponentCategory(name: "Lists", icon: "list.bullet"),
        ComponentCategory(name: "Alerts", icon: "exclamationmark.triangle"),
        ComponentCategory(name: "Modals", icon: "rectangle.center.inset.filled")
    ]
    
    var body: some View {
        NavigationView {
            List(categories) { category in
                NavigationLink(destination: ComponentListView(category: category)) {
                    Label(category.name, systemImage: category.icon)
                }
            }
            .navigationTitle("Component Gallery")
        }
    }
}

struct ComponentListView: View {
    let category: ComponentCategory
    
    var body: some View {
        Group {
            switch category.name {
            case "Buttons":
                ButtonComponents()
            case "Loading Indicators":
                LoadingIndicatorComponents()
            default:
                EmptyComponentView(categoryName: category.name)
            }
        }
        .navigationTitle(category.name)
    }
}

struct EmptyComponentView: View {
    let categoryName: String
    
    var body: some View {
        VStack {
            Image(systemName: "square.stack.3d.up")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            Text("No components yet")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top)
            Text("Check back later for \(categoryName) components")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
}

#Preview {
    ContentView()
}
