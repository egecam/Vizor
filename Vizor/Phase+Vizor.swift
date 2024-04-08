//
//  Phase+Vizor.swift
//  Vizor
//
//  Created by Ege Çam on 8.04.2024.
//

import Foundation
import SwiftUI

var colors: Dictionary<String, Color> = [
    "Sunrise": Color.yellow,
    "Golden Hour": Color.orange,
    "Blue Hour": Color.blue,
    "Twilight": Color.indigo
]

var opacityLevels = [
    0.3,
    0.5,
    0.75
]

func getPhaseList(currentPhase: String) -> Array<String> {
    var phases: Array<String> = ["Sunrise", "Golden Hour", "Blue Hour", "Twilight"]
    
    for phase in 0...phases.count {
        if phases[phase] == currentPhase {
            phases.remove(at: phase)
            break
        }
    }
    
    return phases
}
