//
//  Gallery.swift
//  matterx
//
//  Created by Sayo on 25/11/23.
//

import SwiftUI
import AVKit

struct Gallery: View {
	@State private var videos: [URL] = []
	@Binding var activeVideoURL: URL?
	@State private var reloadTrigger: UUID?

	let columns = [
		GridItem(spacing: 12),
		GridItem(spacing: 12)
	]

	var body: some View {
		ScrollView {
			LazyVGrid(columns: columns, spacing: 12) {
				ForEach(videos, id: \.self) { video in
					ZStack(alignment: .topTrailing) {
						Engine(url: video, height: 222.0, width: 395.0)
						Image(systemName: "checkmark.circle.fill")
							.offset(x: -12, y: 12)
							.opacity(activeVideoURL == video ? 1 : 0)
							.font(.system(size: 16))
							.fontWeight(.light)
							.foregroundColor(.white)
					}
					.cornerRadius(6)
					.background(RoundedRectangle(cornerRadius: 6)
									.stroke(Color.gray.opacity(0.25), lineWidth: 1))
					.onTapGesture {
						withAnimation {
							activeVideoURL = video
							ScreenManager.shared.setVideoURLAndOpenEngine(url: video)
						}
					}
				}
			}
			.padding()
			.onAppear {
				videos = getVideos(from: "_anti")
			}
		}
	}
}




func getVideos(from folderName: String) -> [URL] {
    guard let folderURL = Bundle.main.url(forResource: folderName, withExtension: nil) else {
        print("Folder not found")
        return []
    }

    do {
        let videoURLs = try FileManager.default.contentsOfDirectory(at: folderURL,
                                                                   includingPropertiesForKeys: nil,
                                                                   options: .skipsHiddenFiles)
                        .filter { $0.pathExtension == "mp4" } // Filter for "mp4" files
        return videoURLs
    } catch {
        print("Error while enumerating files \(folderURL.path): \(error.localizedDescription)")
        return []
    }
}
