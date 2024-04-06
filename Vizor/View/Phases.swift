//
//  PhaseCard.swift
//  Vizor
//
//  Created by Ege Çam on 26.03.2024.
//

import SwiftUI

struct Phases: View {
    
    let color: Color = .blue
    var currentPhase: String = "Blue Hour"
    
    var opacityLevels = [
        0.3,
        0.5,
        0.75]
    
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
    
    var body: some View {
        
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                ForEach(0..<20) { index in
                    VStack(spacing: 0) {
                        // CURRENT PHASE
                        ZStack {
                            color.opacity(0.2)
                            
                            VStack {
                                Text("Current phase in your area is")
                                    .font(.caption)
                                Text(currentPhase)
                                    .font(.custom("AntiqueSerie-Regular", size: 52))
                            }
                        }
                        
                        // INCOMING PHASES
                        VStack(spacing: 0) {
                            let phaseList = getPhaseList(currentPhase: currentPhase)
                            
                            ForEach(getPhaseList(currentPhase: currentPhase), id: \.self) { phase in
                                
                                ZStack {
                                    color.opacity(opacityLevels[phaseList.firstIndex(of: phase)!])
                                    Text(phase)
                                        .font(.title)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .containerRelativeFrame(.vertical, alignment: .center)
                }
            }
        }
        .ignoresSafeArea()
        .scrollTargetLayout()
        .scrollTargetBehavior(.paging)
        .scrollBounceBehavior(.basedOnSize)
        
    }
}

#Preview {
    Phases()
}
