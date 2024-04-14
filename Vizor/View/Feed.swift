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
        
        ZStack {
            Color.white
                .opacity(0.2)
                .ignoresSafeArea()
            
            ScrollView {
                ForEach(0..<20) { post in
                    VStack(alignment: .leading) {
                        Text("Leica SL3 Review")
                            .modifier(ArticleTitle())
                            .foregroundStyle(colorTheme)
                        
                        Text("The Leica SL3 (Type 5404) is a 35mm full-frame interchangeable lens mirrorless camera designed to appeal to both stills photographers and videographers.")
                            .modifier(ArticleBody())
                        
                        HStack {
                            
                            Button {
                                // like
                            } label: {
                                Label("18 Likes", systemImage: "heart")
                            }
                            .tint(.primary)
                            
                            
                            Spacer()
                            
                            Button {
                                // comments section
                            } label: {
                                ZStack {
                                    colorTheme.opacity(0.15)
                                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                    Label("9 Comments", systemImage: "message")
                                }
                                .frame(width: 150, height: 35)
                            }
                            .tint(.primary)
                            
                            
                            
                            Spacer()
                            
                        }
                        .bold()
                        .padding(5)
                    }
                    .offset(x: 0, y: 200)
                    .padding()
                }
            }
            
        }
    }
}

#Preview {
    Feed(colorTheme: .cyan)
}
