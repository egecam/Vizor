//
//  Phases.swift
//  Vizor
//
//  Created by Ege Çam on 26.03.2024.
//

import SwiftUI
import MapKit

struct Phases: View {
    @Binding var currentPhase: String
    @Binding var themeColor: Color
    
    @State var phaseTimeList: Dictionary<String, String> = ["": ""]
    @State private var showingMapSheet = false
    @State private var userCoordinate: CLLocationCoordinate2D?
    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    // CURRENT PHASE
                    ZStack {
                        themeColor.opacity(0.2)
                        
                        VStack {
                            Text(Date.now.formatted(date: .long, time: .omitted))
                                .font(.vollkorn(size: 24, width: 100, weight: 500))
                                .padding()
                            
                            VStack {
                                Text("Current phase in your area is")
                                    .font(.caption)
                                    .font(.overused(size: 24, width: 100, weight: 400))
                                Text(currentPhase)
                                    .font(.vollkorn(size: 52, width: 100, weight: 700))
                            }
                            .padding()
                            
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
                                
                                HStack {
                                    Text(phase)
                                    
                                    HStack {
                                        Text(phaseTimeList[phase] ?? "19.41")
                                    }
                                }
                                .font(.overused(size: 32, width: 100, weight: 400))
                                .foregroundStyle(Color.primary)
                            }
                            .padding(5)
                        }
                    }
                    .padding()
                    .background(themeColor.opacity(0.2))
                }
                
            }
            
            // MARK: IN PROGRESS
            /*
             
            .refreshable {
                DispatchQueue.main.async {
                    self.phaseTimeList = getPhaseTimeList(day: Date.now, location: CLLocation(latitude: userCoordinate?.latitude ?? 41.00, longitude: userCoordinate?.longitude ?? 28.54)).mapValues { date in
                        let formatter = DateFormatter()
                        formatter.timeStyle = .short
                        formatter.dateStyle = .none
                        return formatter.string(from: date)
                    }
                }
            }
             
             */
            .modifier(FullscreenScrollViewModifier())
            .onAppear {
                DispatchQueue.main.async {
                    self.phaseTimeList = getPhaseTimeList(day: Date.now, location: CLLocation(latitude: userCoordinate?.latitude ?? 41.00, longitude: userCoordinate?.longitude ?? 28.54)).mapValues { date in
                        let formatter = DateFormatter()
                        formatter.timeStyle = .short
                        formatter.dateStyle = .none
                        return formatter.string(from: date)
                    }
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingMapSheet.toggle()
                    } label: {
                        Image(systemName: "map.fill")
                            .padding()
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 14.0))
                    }
                    .tint(.primary)
                    .sheet(isPresented: $showingMapSheet, content: {
                        MapSheetView { coordinate in
                            self.userCoordinate = coordinate
                            currentPhase = updateCurrentPhase(for: coordinate)
                        }
                    })
                    
                }
                
            }
            .toolbarBackground(.hidden, for: .navigationBar)
        }
    }
}
