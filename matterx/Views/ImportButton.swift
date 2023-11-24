//
//  ImportButton.swift
//  matterx
//
//  Created by Sayo on 25/11/23.
//

import Foundation
import UniformTypeIdentifiers
import SwiftUI

let nsButtonColorStatic = NSColor(red: 1, green: 1, blue: 1, alpha: 0.12)
let nsButtonColorHover = NSColor(red: 1, green: 1, blue: 1, alpha: 0.16)

struct ImportButton: View {
    @Binding var isPickerShown: Bool
    @Binding var selectedFile: URL?
    
    @State var isHover: Bool = false

    
	

    var body: some View{
    Button(action: {
        isPickerShown = true
    }) {
        
        Text("Upload")
            .font(.system(size: 14))
            .fontWeight(.light)
            
        Image(systemName: "plus")
            .font(.system(size: 14))
            .fontWeight(.light)
    }.padding(8).background(Color(nsColor: isHover ? nsButtonColorHover : nsButtonColorStatic))
            .foregroundColor(.white)
            .cornerRadius(6)
            .onHover { hovering in
                isHover = hovering
            }

    .buttonStyle(BorderlessButtonStyle())
    .fileImporter(
                isPresented: $isPickerShown,
                allowedContentTypes: [UTType.mpeg4Movie], // specify the file type
                allowsMultipleSelection: false
            ) { result in
                switch result {
                case .success(let urls):
                    selectedFile = urls.first
                    // handle the selected file
                case .failure(let error):
                    print("Error selecting file: \(error.localizedDescription)")
                }
            }
}
}
