//
//  PhaseCard.swift
//  Vizor
//
//  Created by Ege Çam on 26.03.2024.
//

import SwiftUI

struct Phases: View {
    
    @Binding var currentPhase: String
    @Binding var themeColor: Color
    
    var body: some View {
        
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
                                    .font(.familjen(size: 52, width: 100, weight: 700))
                            }
                        }
                        
                        // INCOMING PHASES
                        VStack(spacing: 0) {
                            let phaseList = getPhaseList(currentPhase: currentPhase)
                            
                            ForEach(getPhaseList(currentPhase: currentPhase), id: \.self) { phase in
                                
                                ZStack {
                                    themeColor.opacity(opacityLevels[phaseList.firstIndex(of: phase)!])
                                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                        .frame(height: 100)
                                        .blur(radius: 1)
                                    
                                    HStack {
                                        Text(phase)
                                            .font(.familjen(size: 36, width: 100, weight: 400))
                                            .font(.title)
                                        
                                        HStack {
                                            Text("19.41")
                                                .font(.title2)
                                        }
                                    }
                                }
                                .padding(5)
                            }
                        }
                        .padding()
                        .background(themeColor.opacity(0.2))
                        
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
    ContentView()
}
