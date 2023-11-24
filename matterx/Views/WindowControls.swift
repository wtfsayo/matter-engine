//
//  WindowControls.swift
//  matterx
//
//  Created by Sayo on 25/11/23.
//

import Foundation
import AppKit
import SwiftUI

struct WindowControlButtons: View {
    var body: some View {
        HStack(spacing: 12) {
            CircleButton(color: .red, iconName: "xmark", action: closeWindow)
            CircleButton(color: .yellow, iconName: "minus", action: minimizeWindow)
            CircleButton(color: .green, iconName: "plus", action: zoomWindow)
        }
    }
    
    func closeWindow() {
        if let window = NSApp.keyWindow {
            window.performClose(nil)
        }
    }
    
    func minimizeWindow() {
        if let window = NSApp.keyWindow {
            window.performMiniaturize(nil)
        }
    }
    
    func zoomWindow() {
        if let window = NSApp.keyWindow {
            window.performZoom(nil)
        }
    }
}


struct CircleButton: View {
    @State private var isHovered = false
    var color: Color
    var iconName: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
                   Circle()
                       .foregroundColor(color)
                       .frame(width: 12, height: 12)
                       .overlay(
                           Group {
                               if isHovered {
                                   Image(systemName: iconName)
                                       .foregroundColor(.black)
                                       .font(.system(size: 8, weight: .heavy))
                               }
                           }
                       )
               }
               .buttonStyle(PlainButtonStyle())
               .onHover { hover in
                   isHovered = hover
               }
           }
}
