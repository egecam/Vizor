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
    @State private var selectedTab = 1
    @State private var animateGradient: Bool = false
    
    var body: some View {
        ZStack {
            
            // SCROLLVIEW FOR TABS
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    VCalendar()
                        .containerRelativeFrame(.horizontal)
                    
                    Phases()
                        .containerRelativeFrame(.horizontal)
                        .scrollTransition(axis: .horizontal) { content, phase in
                            content
                                .scaleEffect(x: phase.isIdentity ? 1 : 0.8, y: phase.isIdentity ? 1 : 0.8)
                        }
                    
                    Feed()
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
