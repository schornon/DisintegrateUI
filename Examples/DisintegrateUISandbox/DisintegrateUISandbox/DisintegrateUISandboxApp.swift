//
//  DisintegrateUISandboxApp.swift
//  DisintegrateUISandbox
//
//  Created by Serhii Chornonoh on 28.02.2024.
//

import SwiftUI

@main
struct DisintegrateUISandboxApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

struct RootView: View {
    @State var snap: Bool = false
    @State var warning: Bool = true
    
    var body: some View {
        if warning {
            WarningView {
                snap.toggle()
            }
            .disintegrate(snap: snap, completion: {
                warning = false
            })
        } else {
            ContentView()
        }
    }
}

#Preview {
    RootView()
}
