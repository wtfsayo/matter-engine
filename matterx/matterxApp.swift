//
//  matterxApp.swift
//  matterx
//
//  Created by Sayo on 24/11/23.
//

import SwiftUI
import AppKit

// Custom NSWindowRepresentable
struct CustomWindow: NSViewRepresentable {
    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async {
            if let window = view.window {
                // Hide standard window buttons
                window.standardWindowButton(.closeButton)?.isHidden = true
                window.standardWindowButton(.miniaturizeButton)?.isHidden = true
                window.standardWindowButton(.zoomButton)?.isHidden = true
                
                // Set borderless style and background color
                window.styleMask.insert(.borderless)
                window.styleMask.remove(.resizable) // Prevent resizing
                window.backgroundColor = NSColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1)
                
                // Set fixed window size
                window.setContentSize(NSSize(width: 840, height: 640))
            }
        }
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {}
}


// SwiftUI App
@main
struct AntiMatterEngine: App {
    var body: some Scene {
		
		
        WindowGroup {
            ContentView()
                .frame(width: 840, height: 640) // Set ContentView frame size
                .background(CustomWindow()) // Apply custom window modifications
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}
