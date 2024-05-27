//
//  SplashView.swift
//  Vizor
//
//  Created by Ege Çam on 9.04.2024.
//

import SwiftUI
import CoreLocation

struct SplashView: View {
    @State var animateGradient: Bool = false
    @State var isActive: Bool = false
    
    @State var currentPhase: String = ""
    @State var themeColor: Color = (colors[""] ?? Color.tangerine)
    @State private var userCoordinate: CLLocationCoordinate2D?
    
    var body: some View {
        ZStack {
            if self.isActive {
                ContentView(currentPhase: currentPhase, themeColor: colors[""] ?? Color.tangerine)
            } else {
                ZStack {
                    Color.black
                    
                   /* LinearGradient(colors: [.tangerine, .bluehour], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .hueRotation(.degrees(animateGradient ? 180 : 0))
                        .onAppear {
                            withAnimation(.easeInOut(duration: 3.5)) {
                                animateGradient.toggle()
                            }
                        }
                        .blur(radius: 3.0)
                        .ignoresSafeArea()
                    */
                    Label("Vizor", systemImage: "dot.viewfinder")
                        .font(.custom("AntiqueSerie-Regular", size: 48))
                        .padding()
                        .foregroundStyle(.sunrise)
                        
                }
                .ignoresSafeArea()
            }
        }
       .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation(.easeOut(duration: 0.2)) {
                    self.isActive = true
                    CLLocationManager().requestWhenInUseAuthorization()
                        currentPhase = updateCurrentPhase(for: userCoordinate ?? CLLocationCoordinate2D(latitude: 42, longitude: 27))
                        themeColor = colors[currentPhase]!
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
