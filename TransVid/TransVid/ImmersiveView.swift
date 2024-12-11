//
//  ImmersiveView.swift
//  TransVid
//
//  Created by Alex Levin on 12/4/24.
//

import SwiftUI
import RealityKit
import RealityKitContent
import AVFoundation

struct ImmersiveView: View {
    @Environment(AppModel.self) private var appModel
    
    var body: some View {
        RealityView { content in
            // Create an anchor for the video
            let anchor = AnchorEntity(world: [0, 1.2, -1])
            content.add(anchor)
            
            // Setup video player if not already setup
            appModel.setupVideoPlayer()
            
            guard let player = appModel.videoPlayer else {
                print("❌ Error: Video player not available")
                return
            }
            
            // Get video dimensions for correct aspect ratio
            Task {
                if let videoTrack = try? await player.currentItem?.asset.loadTracks(withMediaType: .video).first {
                    let videoSize = try await videoTrack.load(.naturalSize)
                    let videoAspect = videoSize.width / videoSize.height
                    
                    // Use a base width of 2 meters and calculate height to maintain aspect ratio
                    let width: Float = 1
                    let height = width / Float(videoAspect)
                    
                    // Create video material
                    let videoMaterial = VideoMaterial(avPlayer: player)
                    
                    // Create plane entity with correct aspect ratio
                    let planeEntity = ModelEntity(
                        mesh: .generatePlane(width: width, height: height),
                        materials: [videoMaterial]
                    )
                    
                    anchor.addChild(planeEntity)
                    print("✅ Video plane created with aspect ratio: \(videoAspect)")
                    
                    // Start playback
                    player.play()
                    
                    // Setup looping
                    NotificationCenter.default.addObserver(
                        forName: .AVPlayerItemDidPlayToEndTime,
                        object: player.currentItem,
                        queue: .main) { _ in
                            player.seek(to: .zero)
                            player.play()
                        }
                }
            }
        }
    }
}

#Preview(immersionStyle: .mixed) {
    ImmersiveView()
        .environment(AppModel())
}
