//
//  AppModel.swift
//  TransVid
//
//  Created by Alex Levin on 12/4/24.
//

import SwiftUI
import AVFoundation

/// Maintains app-wide state
@MainActor
@Observable
class AppModel {
    let immersiveSpaceID = "ImmersiveSpace"
    enum ImmersiveSpaceState {
        case closed
        case inTransition
        case open
    }
    var immersiveSpaceState = ImmersiveSpaceState.closed
    
    // Add video player
    var videoPlayer: AVPlayer?
    
    func setupVideoPlayer() {
        // Check if video player already exists
        guard videoPlayer == nil else { return }
        
        // Try to find video in bundle
        guard let videoURL = Bundle.main.url(forResource: "your_video3", withExtension: "mov") else {
            print("❌ Error: Could not find video file 'your_video3.mov' in app bundle")
            return
        }
        
        // Create asset and check if it's playable
        let asset = AVURLAsset(url: videoURL)
        let playerItem = AVPlayerItem(asset: asset)
        
        // Create and store player
        videoPlayer = AVPlayer(playerItem: playerItem)
        print("✅ Video player setup successfully with URL: \(videoURL)")
    }
}
