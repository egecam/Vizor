//
//  CurrentPhaseHandler.swift
//  Vizor
//
//  Created by Ege Çam on 27.05.2024.
//

import Foundation
import CoreLocation

func updateCurrentPhase(for coordinate: CLLocationCoordinate2D) -> String {
    var currentPhase: String = ""
    let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
    currentPhase = calculatePhase(for: location)
    
    return currentPhase
}
