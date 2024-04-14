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
            
            // APP TITLE
            HStack {
                Label("Vizor", systemImage: "dot.viewfinder")
                    .font(.bricolageGrotesque(size: 26, width: 100, weight: 600))
                    .bold()
                    .padding()
                    .frame(height: 50)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 18.0))
                
                Spacer()
            }
            .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 0))
            .offset(x: 0, y: -350)
        }
    }
    
}

#Preview {
    ContentView()
}
