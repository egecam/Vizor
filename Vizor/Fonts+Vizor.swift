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
    static func bricolageGrotesque(size: CGFloat, width: CGFloat = 0, weight: CGFloat = 0) -> Font {
        return .vFont("Bricolage Grotesque", size: size, axes: [
            2003072104: width,
            2003265652: weight
        ])
    }
    
    static func wittgenstein(size: CGFloat, width: CGFloat = 0, weight: CGFloat = 0) -> Font {
        return .vFont("Wittgenstein", size: size, axes: [
            2003072104: width,
            2003265652: weight
        ])
    }
}
