//
//  ContentView.swift
//  TransVid
//
//  Created by Alex Levin on 12/4/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Welcome to the 491 Gallery")
                .font(.largeTitle)
            
            ToggleImmersiveSpaceButton()
        }
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
        .environment(AppModel())
}
