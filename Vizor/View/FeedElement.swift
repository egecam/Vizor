//
//  FeedElement.swift
//  Vizor
//
//  Created by Ege Çam on 15.04.2024.
//

import SwiftUI

struct FeedElement: View {
    
    let thumbnailPhoto: String
    let aspectRatio: Double
    
    var body: some View {
        ZStack {
            Image(thumbnailPhoto)
                .resizable()
                .overlay(LinearGradient(colors: [.black.opacity(0.8), .white.opacity(0.2)], startPoint: .bottom, endPoint: .top)
                    .opacity(0.5))
            
            VStack {
                
                Spacer()
                
                // gradient fade background
                HStack {
                    Text("Title,")
                        .lineLimit(1)
                        .font(.vollkorn(size: 24, width: 100, weight: 800))
                    Text("2024")
                        .font(.vollkorn(size: 20, width: 100, weight: 600))
                    
                    Spacer()
                }
                .foregroundStyle(.white)
                .padding(.leading)
                
            }
        }
        .aspectRatio(aspectRatio, contentMode: .fit)
    }
}

#Preview {
    FeedElement(thumbnailPhoto: "photobw", aspectRatio: 0.8)
}
