//
//  SunkitManager.swift
//  Vizor
//
//  Created by Ege Çam on 25.04.2024.
//

import Foundation
import SunKit
import CoreLocation

func getPhaseTimeList(day: Date, location: CLLocation) -> [String: Date] {
    let timeZone = TimeZone.current
    var mySun = Sun(location: location, timeZone: timeZone)
    mySun.setDate(day)
    
    return [
        "Sunrise": mySun.sunrise,
        "Golden Hour": mySun.eveningGoldenHourStart,
        "Blue Hour": mySun.eveningBlueHourStart,
        "Twilight": mySun.astronomicalDusk
    ]
}

func calculatePhase(for location: CLLocation) -> String {
    let now = Date()
    let phases = getPhaseTimeList(day: now, location: location)
    
    guard let sunrise = phases["Sunrise"],
          let goldenHour = phases["Golden Hour"],
          let blueHour = phases["Blue Hour"],
          let twilight = phases["Twilight"] else {
        return "Unknown"
    }
    
    switch now {
    case ..<sunrise:
        return "Night"
    case sunrise..<goldenHour:
        return "Sunrise"
    case goldenHour..<blueHour:
        return "Golden Hour"
    case blueHour..<twilight:
        return "Blue Hour"
    case twilight...:
        return "Twilight"
    default:
        return "Unknown"
    }
}

