//
//  Feed.swift
//  Vizor
//
//  Created by Ege Çam on 8.04.2024.
//

import SwiftUI

struct Feed: View {
    var body: some View {
        ZStack {
            Color.indigo
                .opacity(0.2)
                .ignoresSafeArea()
            
            VStack {
                Text("Heading")
                    .modifier(ArticleTitle())
                Text("The quick brown fox jumps over the lazy dog and runs away.")
                    .modifier(ArticleBody())
                    .padding()
            }
        }
    }
}

#Preview {
    Feed()
}
