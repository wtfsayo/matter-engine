import SwiftUI
import Cocoa
import Combine

class ScreenManager {
	
	static let shared = ScreenManager()
	private var windows: [NSWindow] = []
	private var videoURL: URL?
	private var cancellables = Set<AnyCancellable>()

	init() {
		let screenChangePublisher = NotificationCenter.default.publisher(for: NSApplication.didChangeScreenParametersNotification)
		screenChangePublisher
			.sink { [weak self] _ in self?.screenDidChange() }
			.store(in: &cancellables)
	}

	func setVideoURLAndOpenEngine(url: URL) {
		self.videoURL = url
		openEngine()
	}

	private func screenDidChange() {
		closeAllWindows()
		if videoURL != nil {
			openEngine()
		}
	}

	private func openEngine() {
		guard let videoURL = videoURL else { return }

		for screen in NSScreen.screens {
			let contentView = Engine(url: videoURL)

			let window = NSWindow(
				contentRect: NSRect(x: 0, y: 0, width: screen.frame.width, height: screen.frame.height),
				styleMask: [.borderless],
				backing: .buffered, defer: false
			)
			
			window.center()
			window.setFrameOrigin(NSPoint(x: screen.frame.origin.x, y: screen.frame.origin.y))
			window.makeKeyAndOrderFront(nil)
			window.contentView = NSHostingView(rootView: contentView)
			window.isReleasedWhenClosed = false
			window.isMovableByWindowBackground = false
			window.level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.desktopWindow)))

			windows.append(window)
		}
	}

	private func closeAllWindows() {
		for window in windows {
			window.close()
		}
		windows.removeAll()
	}
}
