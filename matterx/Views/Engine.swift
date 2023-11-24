//
//  Engine.swift
//  matterx
//
//  Created by Sayo on 25/11/23.
//

//
//  Engine.swift
//  matterx
//
//  Created by Sayo on 25/11/23.
//

import Foundation
import UniformTypeIdentifiers
import SwiftUI
import AVKit

struct CustomVideoPlayerView: NSViewRepresentable {
	var player: AVPlayer

	func makeNSView(context: Context) -> NSView {
		let view = NSView()
		view.wantsLayer = true  // Ensuring the view is layer-hosted

		let playerLayer = AVPlayerLayer(player: player)
		playerLayer.videoGravity = .resizeAspectFill
		playerLayer.frame = view.bounds
		playerLayer.autoresizingMask = [.layerWidthSizable, .layerHeightSizable]
		view.layer?.addSublayer(playerLayer)

		return view
	}

	func updateNSView(_ nsView: NSView, context: Context) {
		if let layer = nsView.layer?.sublayers?.first as? AVPlayerLayer {
			layer.frame = nsView.bounds  // Ensure the frame matches the view bounds
		}
	}
}



struct Engine: View {
	let player: AVPlayer
	var height: CGFloat? // Optional height parameter
	var width: CGFloat?  // Optional width parameter

	init(url: URL, height: CGFloat? = nil, width: CGFloat? = nil) {
		self.player = AVPlayer(url: url)
		self.height = height
		self.width = width
	}

	var body: some View {
		CustomVideoPlayerView(player: player)
			// Apply frame with optional values
			.frame(width: width, height: height)
			// Provide a minimum height if nil
			.frame(minHeight: height ?? 100) // Example minimum height
			.onAppear {
				player.play()
				player.isMuted = true
				NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
					player.seek(to: .zero)
					player.play()
				}
			}
	}
}
