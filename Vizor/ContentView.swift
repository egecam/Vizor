//
//  ContentView.swift
//  Vizor
//
//  Created by Ege Çam on 25.03.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selectedTab = 1
    
    var body: some View {
        
        ZStack {
            TabView(selection: $selectedTab) {
                Text("Calendar")
                    .tabItem {
                        Label("Calendar", systemImage: "calendar")
                    }
                
                Phases()
                    .tag(1)
                    .tabItem {
                        Label("Daylight Phases", systemImage: "house.fill")
                    }
                
                VStack {
                    Text("Heading")
                        .font(.custom("AntiqueSerie-Regular", size: 24))
                    Text("The quick brown fox jumps over the lazy dog and runs away.")
                        .font(.wittgenstein(size: 16, width: 100, weight: 200))
                }
                .tabItem {
                    Label("Feed", systemImage: "square.stack.fill")
                }
            }
            
            HStack {
                Label("Vizor", systemImage: "dot.viewfinder")
                    .font(.bricolageGrotesque(size: 24, width: 100, weight: 600))
                    .bold()
                    .padding()
                
                Spacer()
            }
            .offset(x: 0, y: -350)
        }
    }
    
}

#Preview {
    ContentView()
}
