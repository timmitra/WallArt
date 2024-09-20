//
//  ContentView.swift
//  WallArt
//
//  Created by Christopher J. Roura on 6/13/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    
    var body: some View {
        VStack {
            Text("Welcome to Wall Art in Vision Pro.")
                .font(.extraLargeTitle)
            
//            Model3D(named: "Scene", bundle: realityKitContentBundle)
//                .padding(.bottom, 50)
//
//            Text("Hello, world!")
//
            ToggleImmersiveSpaceButton()
        }
        .padding(50)
        .glassBackgroundEffect()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
