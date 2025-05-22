//
//  ViewController.swift
//  SimpleLiDARApp
//
//  Created by Barsbold Bayarerdene on 22/05/2025.
//

import LiDARKit
import ARKit

class ViewController: UIViewController, LiDARCaptureDelegate {
  private var captureSession: LiDARCaptureSession!
  private var arSession: ARSession!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCaptureSession()
  }
  
  private func setupCaptureSession() {
    arSession = ARSession()
    
    // Configure AR session for LiDAR
    let configuration = ARWorldTrackingConfiguration()
    guard ARWorldTrackingConfiguration.supportsFrameSemantics(.sceneDepth) else {
      // Handle devices without LiDAR
      return
    }
    
    // Enable scene depth
    configuration.frameSemantics = [.sceneDepth, .smoothedSceneDepth]
    
    // Start AR session
    arSession.run(configuration, options: [.removeExistingAnchors, .resetTracking])
    
    // Create capture session
    captureSession = LiDARCaptureSession(session: arSession)
    captureSession.delegate = self
    captureSession.startCapture()
  }
  
  func captureSession(_ session: LiDARCaptureSession, didCapturePointCloud pointCloud: PointCloud) {
      // Handle captured point cloud
      print("Captured point cloud with transform: \(pointCloud.transform)")
  }

  func captureSession(_ session: LiDARCaptureSession, didFailWithError error: Error) {
      // Handle errors
      print("Capture error: \(error.localizedDescription)")
  }
}
