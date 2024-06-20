//
//  Fonts+Vizor.swift
//  Vizor
//
//  Created by Ege Çam on 26.03.2024.
//

import Foundation
import SwiftUI
import VFont

extension Font {
    static func vollkorn(
        size: CGFloat,
        width: CGFloat = 0,
        weight: CGFloat = 0
    ) -> Font {
        
        return .vFont("Vollkorn", size: size, axes: [
            2003265652: weight
        ])
        
    }
    
    
    static func overused(
        size: CGFloat,
        width: CGFloat = 0,
        weight: CGFloat = 0
    ) -> Font {
        
        return .vFont("Overused Grotesk", size: size, axes: [
            2003265652: weight
        ])
        
    }
}

struct ArticleBody: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.vollkorn(size: 20, width: 100, weight: 100))
    }
}

struct ArticleTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.overused(size: 36, width: 100, weight: 700))
    }
}
