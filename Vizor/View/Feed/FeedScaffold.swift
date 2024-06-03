//
//  FeedScaffold.swift
//  Vizor
//
//  Created by Ege Çam on 8.04.2024.
//

import SwiftUI
import SwiftData

struct FeedScaffold: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    @State var isUserLoggedIn: Bool = false
    
    var body: some View {
        if isUserLoggedIn {
            Feed()
        }
        else {
            SignInView(isUserLoggedIn: $isUserLoggedIn)
        }
        
    }
}

#Preview {
    FeedScaffold()
}
