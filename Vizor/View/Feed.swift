//
//  Feed.swift
//  Vizor
//
//  Created by Ege Çam on 8.04.2024.
//

import SwiftUI

struct Feed: View {
    
    @State var colorTheme: Color
    
    var body: some View {
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
        }
        .offset(x: 0, y: 120)
    }
}

#Preview {
    Feed(colorTheme: .cyan)
}
