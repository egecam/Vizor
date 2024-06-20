//
//  LocationManager.swift
//  Vizor
//
//  Created by Ege Çam on 15.05.2024.
//

import Foundation
import Combine
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var userLocation: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var locationError: Error?
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                switch self.authorizationStatus {
                case .notDetermined:
                    self.locationManager.requestWhenInUseAuthorization()
                case .authorizedWhenInUse, .authorizedAlways:
                    self.locationManager.startUpdatingLocation()
                case .denied, .restricted:
                    self.locationError = NSError(
                        domain: "LocationError",
                        code: 1,
                        userInfo: [NSLocalizedDescriptionKey: "Location access denied or restricted"])
                @unknown default:
                    self.locationError = NSError(
                        domain: "LocationError",
                        code: 1,
                        userInfo: [NSLocalizedDescriptionKey: "Unknown authorization status"])
                }
            } else {
                self.locationError = NSError(
                    domain: "LocationError",
                    code: 1,
                    userInfo: [NSLocalizedDescriptionKey: "Location services are not enabled"])
            }
        }
    }
    
    
    func stopUpdatingLocation() {
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.userLocation = location
        self.locationError = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
        self.locationError = error
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationStatus = status
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            self.startUpdatingLocation()
        case .denied, .restricted:
            self.locationError = NSError(
                domain: "LocationError",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Location access denied or restricted"])
        case .notDetermined:
            break
        @unknown default:
            // Handle any future cases that may be added
            self.locationError = NSError(
                domain: "LocationError",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Unknown authorization status"])
        }
    }
}

