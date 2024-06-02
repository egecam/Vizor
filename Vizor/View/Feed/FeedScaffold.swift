//
//  FeedScaffold.swift
//  Vizor
//
//  Created by Ege Çam on 8.04.2024.
//

import SwiftUI

struct FeedScaffold: View {
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
