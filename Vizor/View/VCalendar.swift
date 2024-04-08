//
//  Calendar.swift
//  Vizor
//
//  Created by Ege Çam on 8.04.2024.
//

import SwiftUI

struct VCalendar: View {
    var body: some View {
        ZStack {
            Color.indigo
                .opacity(0.2)
                .ignoresSafeArea()
            
            VStack {
                Text("Calendar")
                    .modifier(ArticleTitle())
                Text("Now is \(Date.now)")
                    .modifier(ArticleBody())
                    .padding()
            }
        }
    }
}

#Preview {
    VCalendar()
}
