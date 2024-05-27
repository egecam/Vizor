//
//  Phase+Vizor.swift
//  Vizor
//
//  Created by Ege Çam on 8.04.2024.
//

import Foundation
import SwiftUI

var colors: Dictionary<String, Color> = [
    "Sunrise": Color.sunrise,
    "Golden Hour": Color.goldenhour,
    "Blue Hour": Color.bluehour,
    "Twilight": Color.twilight
]

var opacityLevels = [
    0.3,
    0.5,
    0.7
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

func setTheme(dynamicPreference: Bool, theme: Color) -> Color {
    if dynamicPreference == true {
        let theme = theme
        return theme
    }
    else {
        let theme = Color.tangerine
        return theme
    }
}

var previewPhase = "Golden Hour"
var previewColor = Color.goldenhour
