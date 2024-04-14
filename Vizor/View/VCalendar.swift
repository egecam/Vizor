//
//  Calendar.swift
//  Vizor
//
//  Created by Ege Çam on 8.04.2024.
//

import SwiftUI

struct VCalendar: View {
    @State private var date = Date()
    
    var body: some View {
        ZStack {
            Color.white
                .opacity(0.2)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("Calendar")
                    .modifier(ArticleTitle())
                
                Text("Now is \(Date.now)")
                    .modifier(ArticleBody())
                
                DatePicker(
                    "Start Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .tint(.primary)
            }
            .padding()
        }
    }
}

#Preview {
    VCalendar()
}
