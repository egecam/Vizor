//
//  CurrentPhaseHandler.swift
//  Vizor
//
//  Created by Ege Çam on 27.05.2024.
//

import Foundation
import CoreLocation

func updateCurrentPhase(for coordinate: CLLocationCoordinate2D?) -> String {
    guard let coordinate = coordinate else {
        return "Unknown"
    }
    let location = CLLocation(
        latitude: coordinate.latitude,
        longitude: coordinate.longitude)
    return calculatePhase(for: location)
}

