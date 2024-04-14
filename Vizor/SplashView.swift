//
//  SplashView.swift
//  Vizor
//
//  Created by Ege Çam on 9.04.2024.
//

import SwiftUI

struct SplashView: View {
    @State var animateGradient: Bool = false
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            if self.isActive {
                ContentView()
            } else {
                ZStack {
                    Color.black
                    
                   /* LinearGradient(colors: [.tangerine, .bluehour], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .hueRotation(.degrees(animateGradient ? 180 : 0))
                        .onAppear {
                            withAnimation(.easeInOut(duration: 3.5)) {
                                animateGradient.toggle()
                            }
                        }
                        .blur(radius: 3.0)
                        .ignoresSafeArea()
                    */
                    Label("Vizor", systemImage: "dot.viewfinder")
                        .font(.bricolageGrotesque(size: 48, width: 100, weight: 600))
                        .bold()
                        .padding()
                }
                .ignoresSafeArea()
            }
        }
       .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation(.easeOut(duration: 0.2)) {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
