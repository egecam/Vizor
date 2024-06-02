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
    @State var themeColor: Color = colors["Unknown"] ?? Color.tangerine
    @State private var userCoordinate: CLLocationCoordinate2D?
    
    var body: some View {
        ZStack {
            if self.isActive {
                Home(currentPhase: currentPhase, themeColor: themeColor)
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
            locationManager.requestLocationAuthorization()
        }
        .onReceive(locationManager.$userLocation) { location in
            guard let location = location else { return }
            userCoordinate = location.coordinate
            currentPhase = updateCurrentPhase(for: userCoordinate ?? CLLocationCoordinate2D(latitude: 42, longitude: 27))
            
            if let newThemeColor = colors[currentPhase] {
                themeColor = newThemeColor
            } else {
                themeColor = Color.tangerine
            }
            self.isActive = true
        }
        .onReceive(locationManager.$locationError) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                // Handle the error accordingly
            }
        }
    }
}

#Preview {
    SplashView()
}

