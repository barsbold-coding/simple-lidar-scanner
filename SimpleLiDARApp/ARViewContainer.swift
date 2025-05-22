//
//  ARViewContainer.swift
//  SimpleLiDARApp
//
//  Created by Barsbold Bayarerdene on 22/05/2025.
//

import SwiftUI
import ARKit
import RealityKit

class LiDARScannerDelegate: NSObject, ARSessionDelegate {
  func session(_ session: ARSession, didUpdate frame: ARFrame) {
    guard let depthData = frame.sceneDepth else { return }
    
    // Process depth data
    // depthData.depthMap contains the depth values
    // frame.camera contains the camera transform
    
    // Example: Get the size of the depth map
    let depthWidth = CVPixelBufferGetWidth(depthData.depthMap)
    let depthHeight = CVPixelBufferGetHeight(depthData.depthMap)
    
    print("Depth map size: \(depthWidth) x \(depthHeight)")
  }
}

struct ARViewContainer: UIViewRepresentable {
  let sessionDelegate = LiDARScannerDelegate()
  
  func makeUIView(context: Context) -> ARView {
    let arView = ARView(frame: .zero)
    
    // Configure AR session for LiDAR
    let configuration = ARWorldTrackingConfiguration()
    
    // Enable scene depth and scene reconstruction if available
    if ARWorldTrackingConfiguration.supportsFrameSemantics(.sceneDepth) {
        configuration.frameSemantics = [.sceneDepth, .smoothedSceneDepth]
    }
    
    if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
        configuration.sceneReconstruction = .mesh
    }
    
    arView.session.delegate = sessionDelegate
    
    // Run the AR session
    arView.session.run(configuration)
  
    // Debug options to visualize the mesh
    arView.debugOptions = [.showSceneUnderstanding]
    
    return arView
  }
  
  func updateUIView(_ uiView: ARView, context: Context) {}
}
