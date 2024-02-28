//
//  WarningView.swift
//  DisintegrateUISandbox
//
//  Created by Serhii Chornonoh on 28.02.2024.
//

import SwiftUI

struct WarningView: View {
    let snapAction: () -> Void
    
    var body: some View {
        VStack(spacing: 26) {
            Text("WARNING!")
                .fontWeight(.bold)
                .font(.title)
            
            Text("Avengers: Infinity War\nspoiler ahead!")
                .font(.title3)
                .multilineTextAlignment(.center)
            
            Button("Snap!") {
                snapAction()
            }
        }
    }
}

#Preview {
    WarningView(snapAction: {})
}
