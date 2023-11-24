//
//  SegmentPicker.swift
//  matterx
//
//  Created by Sayo on 26/11/23.
//

import SwiftUI

struct SegmentPicker: View {
    let options: [String]
    @Binding var selectedOption: String

    var body: some View {
        HStack {
            ForEach(options, id: \.self) { option in
                Text(option)
                    .font(.system(size: 16))
                    .fontWeight(.light)
                    .foregroundColor(self.selectedOption == option ? .white : .init(white: 0.9))
                    .frame(width: 77, height: 32)
                    .background(
                        self.selectedOption == option
                        ? RoundedRectangle(cornerRadius: 8).fill(Color(nsButtonColorStatic))
                        : RoundedRectangle(cornerRadius: 8).fill(Color.clear)
                    )
                    .onTapGesture {
                        withAnimation {
                            self.selectedOption = option
                        }
                    }
            }
        }
        .padding(4)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .frame(height: 40)
        
    }
}
