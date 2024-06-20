//
//  Home.swift
//  Vizor
//
//  Created by Ege Çam on 25.03.2024.
//

import SwiftUI
import SwiftData
import VFont
import MapKit

struct Home: View {
    
    @State var currentPhase: String
    @State var themeColor: Color
    
    @State var userCoordinate: CLLocationCoordinate2D?
    @State private var currentZoom = 0.0
    @State private var totalZoom = 1.0
    
    var body: some View {
        
        ZStack {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ZStack {
                        Phases(currentPhase: $currentPhase, themeColor: $themeColor)
                            .scrollTransition(axis: .horizontal) { content, phase in
                                content
                                    .scaleEffect(x: phase.isIdentity ? 1 : 0.8, y: phase.isIdentity ? 1 : 0.8)
                            }
                            .containerRelativeFrame(.horizontal)
                    }
                    
                    RootView()
                        .padding(.top, 50)
                        .background(.black)
                        .containerRelativeFrame(.horizontal)
                }
            }
            .defaultScrollAnchor(.leading)
            .scrollIndicators(.hidden)
            .modifier(FullscreenScrollViewModifier())
        }
    }
}

#Preview {
    Home(currentPhase: "Twilight", themeColor: colors[""] ?? Color.twilight)
}
