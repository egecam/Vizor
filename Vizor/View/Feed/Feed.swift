//
//  Feed.swift
//  Vizor
//
//  Created by Ege Çam on 3.06.2024.
//

import SwiftUI
import SwiftData

struct Feed: View {
    @Environment(\.modelContext) var modelContext
    @Query var posts: [Post]
    
    @State private var showingHeader = true
    @State private var turningPoint = CGFloat.zero
    
    let thresholdScrollDistance: CGFloat = 50
    
    var body: some View {
        VStack {
            if showingHeader {
                HStack {
                    HStack(alignment: .center) {
                        Text("Vizor")
                            .font(.custom("AntiqueSerie-Regular", size: 38))
                        Text("Feed")
                            .font(.system(size: 36))
                            .fontWeight(.light)
                    }
                    .foregroundStyle(.white)
                    .safeAreaPadding()
                    
                    Spacer()
                }
                .transition(
                    .asymmetric(
                        insertion: .push(from: .top),
                        removal: .push(from: .bottom)
                    )
                )
            }
            
            GeometryReader { outer in
                let outerHeight = outer.size.height
                ScrollView {
                    Grid {
                        ForEach(1..<9) { _ in
                            GridRow {
                                FeedElement(thumbnailPhoto: "photobw", aspectRatio: 0.8)
                                    .padding(4)
                                FeedElement(thumbnailPhoto: "photocolor", aspectRatio: 0.8)
                                    .padding(4)
                            }
                            .scaledToFit()
                        }
                    }
                    .background {
                        GeometryReader { proxy in
                            let contentHeight = proxy.size.height
                            let minY = max(
                                min(0, proxy.frame(in: .named("ScrollView")).minY),
                                outerHeight - contentHeight
                            )
                            Color.clear
                                .onChange(of: minY) { oldValue, newValue in
                                    if (showingHeader && newValue > oldValue) || (!showingHeader && newValue < oldValue) {
                                        turningPoint = newValue
                                    }
                                    if (showingHeader && (turningPoint - newValue) > thresholdScrollDistance) ||
                                        (!showingHeader && (newValue - turningPoint) > thresholdScrollDistance) {
                                        showingHeader = newValue > turningPoint
                                    }
                                }
                        }
                    }
                }
                .coordinateSpace(name: "ScrollView")
            }
            .padding(.top, 1)
        }
        .background(.black)
        .animation(.easeInOut, value: showingHeader)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    Feed()
}
