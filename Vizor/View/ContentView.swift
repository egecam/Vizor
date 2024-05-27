//
//  ContentView.swift
//  Vizor
//
//  Created by Ege Çam on 25.03.2024.
//

import SwiftUI
import SwiftData
import VFont

struct ContentView: View {
    @State var currentPhase: String = "Golden Hour"
    @State var themeColor: Color = colors["Golden Hour"] ?? .cyan
    
    @State var dynamicThemePreference: Bool = true
    
    @State var stateTheme: Color = .cyan
    
    var body: some View {
        ZStack {
            // SCROLLVIEW FOR TABS
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    VCalendar()
                        .containerRelativeFrame(.horizontal)
                    
                    ZStack {
                        Phases(currentPhase: $currentPhase, themeColor: $themeColor)
                            .containerRelativeFrame(.horizontal)
                            .scrollTransition(axis: .horizontal) { content, phase in
                                content
                                    .scaleEffect(x: phase.isIdentity ? 1 : 0.8, y: phase.isIdentity ? 1 : 0.8)
                            }
                    }
                    
                    Feed(colorTheme: setTheme(dynamicPreference: dynamicThemePreference, theme: colors[currentPhase]!))
                        .containerRelativeFrame(.horizontal)
                }
            }
            .defaultScrollAnchor(.center)
            .scrollIndicators(.hidden)
            .modifier(FullscreenScrollViewModifier())
            
        }
        .onAppear {
            CLLocationManager().requestWhenInUseAuthorization()
            DispatchQueue.main.async {
                currentPhase = updateCurrentPhase(for: userCoordinate ?? CLLocationCoordinate2D(latitude: 42, longitude: 27))
                themeColor = colors[currentPhase]!
            }
        }
    }
}

#Preview {
    ContentView(currentPhase: "Golden Hour", themeColor: colors[""] ?? Color.tangerine)
}
