//
//  FullscreenScrollView.swift
//  Vizor
//
//  Created by Ege Çam on 8.04.2024.
//

import SwiftUI

struct FullscreenScrollViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .ignoresSafeArea()
            .scrollTargetLayout()
            .scrollTargetBehavior(.paging)
            .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    ScrollView(.vertical) {
        VStack(spacing: 0) {
            ForEach(1..<19) { index in
                ZStack {
                    Color.blue.opacity(0.5)
                    
                    Text("Content")
                        .modifier(ArticleTitle())
                }
                .frame(maxWidth: .infinity)
                .containerRelativeFrame(.vertical, alignment: .center)
            }
        }
    }
    .modifier(FullscreenScrollViewModifier())
}
