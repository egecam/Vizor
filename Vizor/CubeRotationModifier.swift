//
//  CubeRotationModifier.swift
//  Vizor
//
//  Created by Ege Çam on 6.04.2024.
//

import SwiftUI

struct CubeRotationModifier: Animatable {
    
    var pct: Double
    
    var animatableData: Double {
        get { pct }
        set { pct = newValue }
    }
    
    func body(content: Content) -> some View {
        content
    }
}
