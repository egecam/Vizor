//
//  PhaseCard.swift
//  Vizor
//
//  Created by Ege Çam on 26.03.2024.
//

import SwiftUI

struct Phases: View {
    
    var currentPhase: String = "Twilight"
    
    var body: some View {
        
        let themeColor: Color? = colors[currentPhase]
        
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                ForEach(0..<20) { index in
                    VStack(spacing: 0) {
                        // CURRENT PHASE
                        ZStack {
                            themeColor.opacity(0.2)
                            
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
                                    themeColor.opacity(opacityLevels[phaseList.firstIndex(of: phase)!])
                                    HStack {
                                        Text(phase)
                                            .modifier(ArticleTitle())
                                            .font(.title)
                                        
                                        HStack {
                                            Text("19.41")
                                                .font(.title2)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .containerRelativeFrame(.vertical, alignment: .center)
                }
            }
        }
        .modifier(FullscreenScrollViewModifier())
        
    }
}

#Preview {
    Phases()
}
