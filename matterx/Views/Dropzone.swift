//
//  Dropzone.swift
//  matterx
//
//  Created by Sayo on 25/11/23.
//

import Foundation
import UniformTypeIdentifiers
import SwiftUI

let strokeStyleRegular = StrokeStyle(lineWidth: 1, dash: [16])
let strokeStyleDrop = StrokeStyle(lineWidth: 1)

struct Dropzone: View {
    
    @Binding var isPickerShown: Bool
    @Binding var isTargeted: Bool
    // @Binding var selectedFile: URL?
    
    
    
    var body: some View {
        
        let strokeConfig = isTargeted
        ? (color: Color.blue, style: strokeStyleDrop)
        : (color: Color.white, style: strokeStyleRegular)
        
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .stroke(strokeConfig.color, style: strokeConfig.style)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.white.opacity(0.03))
                )
            
            VStack(spacing: 20) {
                Image(systemName: "square.and.arrow.up.on.square.fill")
                    .font(.custom("Image", size: 32))
                    .fontWeight(.light)
                
                VStack(spacing: 6) {
                    Text("Drop your video here")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                           .fontWeight(.light)
                    
                    
                    Text("File must be an .mp4")
                        .font(.system(size: 16))
                           .fontWeight(.light)
                        .foregroundColor(.gray)
                    
                }
                
            }
            .padding()
            .frame(height: 400)
            .onDrop(of: [.fileURL], isTargeted: nil) { providers in
                providers.first?.loadObject(ofClass: URL.self) { (url, error) in
                    // Handle the asynchronously loaded URL
                    DispatchQueue.main.async {
                        if let validUrl = url { // Safely unwrapping the optional
							ScreenManager.shared.setVideoURLAndOpenEngine(url: validUrl)
                            copyFileToAppStorage(sourceUrl: validUrl)
                        }
                    }
                }
                return true
            }
            
            
        }
    }
}


func copyFileToAppStorage(sourceUrl: URL) {
    let fileManager = FileManager.default

    // Path to the '_uploads' directory
    guard let appDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
        return
    }

    let uploadsDirectory = appDirectory.appendingPathComponent("_uploads")

    print(uploadsDirectory)
    
    // Create '_uploads' directory if it doesn't exist
    if !fileManager.fileExists(atPath: uploadsDirectory.path) {
        do {
            try fileManager.createDirectory(at: uploadsDirectory, withIntermediateDirectories: true)
        } catch {
            print("Failed to create '_uploads' directory: \(error)")
            return
        }
    }

    // Destination URL in the '_uploads' directory
    let destinationUrl = uploadsDirectory.appendingPathComponent(sourceUrl.lastPathComponent)

    // Copy the file
    do {
        if fileManager.fileExists(atPath: destinationUrl.path) {
            try fileManager.removeItem(at: destinationUrl)
        }
        try fileManager.copyItem(at: sourceUrl, to: destinationUrl)
        // Optionally update state or perform further actions
    } catch {
        print("File copy error: \(error)")
    }
}
