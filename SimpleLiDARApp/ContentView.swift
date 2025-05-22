//
//  ContentView.swift
//  SimpleLiDARApp
//
//  Created by Barsbold Bayarerdene on 22/05/2025.
//

import RealityKit

import ARKit
import SwiftUI

struct ContentView: View {
  @State private var hasLiDAR = false
  
  var body: some View {
    VStack {
      if hasLiDAR {
        ARViewContainer()
          .edgesIgnoringSafeArea(.all)
      } else {
        Text("This device does not have a LiDAR sensor")
          .padding()
      }
    }
    .onAppear {
      checkLiDARAvailability()
    }
  }
  
  func checkLiDARAvailability() {
    // Check if device supports scene depth
    hasLiDAR = ARWorldTrackingConfiguration.supportsFrameSemantics(.sceneDepth)
  }
}


#Preview {
    ContentView()
}
