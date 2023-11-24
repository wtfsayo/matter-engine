import SwiftUI
import UniformTypeIdentifiers
import AVKit



struct ContentView: View {
    let options = ["Anti", "Apple", "Uploads"]
    
    @State var activeVideoURL: URL?
    @State private var isPickerShown = false
    @State private var selectedFile: URL?
    @State private var isTargeted = false
    @State private var selectedOption = "Anti"
    
	
	var body: some View {
        VStack{
        HStack {
            WindowControlButtons()
            Spacer()
           
            SegmentPicker(options: options, selectedOption: $selectedOption)
            Spacer();
            ImportButton(isPickerShown: $isPickerShown, selectedFile: $selectedFile);
        }.padding(.horizontal, 20)
        
        
        
            
            switch selectedOption {
            case "Anti":
                Gallery(activeVideoURL: $activeVideoURL)
            case "Apple":
                Gallery(activeVideoURL: $activeVideoURL)
            case "Uploads":
                Dropzone(isPickerShown: $isPickerShown, isTargeted: $isTargeted)
                    .padding(20)
            default:
                Gallery(activeVideoURL: $activeVideoURL)
            }
            
        }.offset(y:-16)
    }
    
}
