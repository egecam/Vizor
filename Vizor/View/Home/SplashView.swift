//
//  SplashView.swift
//  Vizor
//
//  Created by Ege Çam on 9.04.2024.
//

import SwiftUI
import CoreLocation

struct SplashView: View {
    @StateObject private var locationManager = LocationManager()
    @State var animateGradient: Bool = false
    @State var isActive: Bool = false
    
    @State var currentPhase: String = ""
    @State var themeColor: Color = (colors[""] ?? Color.tangerine)
    @State var userCoordinate: CLLocationCoordinate2D?
    
    var body: some View {
        ZStack {
            if self.isActive {
                Home(currentPhase: currentPhase, themeColor: colors[""] ?? Color.tangerine)
            } else {
                ZStack {
                    Color.black
                    
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
                    if locationManager.authorizationStatus == .notDetermined {
                        locationManager.startUpdatingLocation()
                    } else {
                        handleLocationUpdate()
                    }
                }
            }
        }
        .onChange(of: locationManager.authorizationStatus) { status in
            if status == .authorizedWhenInUse || status == .authorizedAlways {
                handleLocationUpdate()
            }
        }
    }
    
    private func handleLocationUpdate() {
        if let location = locationManager.userLocation {
            userCoordinate = location.coordinate
        } else {
            // Varsayılan konumu kullan
            userCoordinate = CLLocationCoordinate2D(latitude: 42, longitude: 27)
        }
        currentPhase = updateCurrentPhase(for: userCoordinate ?? CLLocationCoordinate2D(latitude: 42, longitude: 27))
        
        if let newThemeColor = colors[currentPhase] {
            themeColor = newThemeColor
        } else {
            themeColor = Color.tangerine
        }
        self.isActive = true
    }
}

#Preview {
    SplashView()
}
