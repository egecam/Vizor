//
//  MapSheetView.swift
//  Vizor
//
//  Created by Ege Çam on 9.05.2024.
//

import SwiftUI
import MapKit

struct MapSheetView: View {
    @Environment(\.dismiss) var dismiss
    @Namespace var mapScope
    @StateObject private var locationManager = LocationManager()
    
    var onLocationSelected: (CLLocationCoordinate2D) -> Void
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Choose your current location")
                    .font(.vollkorn(size: 24, width: 100, weight: 600))
                    .lineLimit(1)
                    .padding()
                
                VStack {
                    Map(coordinateRegion: .constant(
                        MKCoordinateRegion(
                            center: locationManager.userLocation?.coordinate ?? CLLocationCoordinate2D(
                                latitude: 37.7749,
                                longitude: -122.4194),
                            span: MKCoordinateSpan(
                                latitudeDelta: 0.05,
                                longitudeDelta: 0.05))),
                        showsUserLocation: true)
                    .frame(width: 350, height: 350)
                    .clipShape(RoundedRectangle(cornerRadius: 18.0))
                    .mapControls {
                        MapUserLocationButton()
                    }
                    
                    
                    Button {
                        if let location = locationManager.userLocation {
                            onLocationSelected(location.coordinate)
                        }
                        dismiss()
                    } label: {
                        ZStack {
                            Color.green.opacity(0.3)
                                .frame(width: 350, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 18.0))
                            
                            Label("Confirm Location", systemImage: "checkmark.circle")
                                .foregroundStyle(.green)
                                .bold()
                        }
                    }
                    
                }
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundStyle(.gray)
                    }
                    
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
        }
        
    }
}

#Preview {
    MapSheetView(onLocationSelected: { _ in })
}
