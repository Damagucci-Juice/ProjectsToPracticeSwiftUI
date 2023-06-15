//
//  ContentView.swift
//  Instafilter
//
//  Created by Gucci on 2023/06/08.
//

import SwiftUI
import PhotosUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {    
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var filterIntensity = 0.5
    @State private var item: PhotosPickerItem?
    @State private var currentFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    PhotosPicker("select avatar", selection: $item, matching: .images)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onChange(of: item, perform: selectedNewItem)
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity) { _ in
                            applyProcessing()
                        }
                }
                
                HStack {
                    Button("Change Filter", action: changeFilter)
                    Spacer()
                    Button("Save", action: save)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("InstaFilter")
        }
    }
    
    private func selectedNewItem(_ item: PhotosPickerItem?) {
        Task {
            if let data = try? await item?.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    inputImage = uiImage
                    loadImage()
                    return
                }
            }
        }
    }
    
    private func loadImage() {
        guard let inputImage = inputImage else { return }

        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    private func applyProcessing() {
        currentFilter.intensity = Float(filterIntensity)

        guard let outputImage = currentFilter.outputImage else { return }

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
    
    func changeFilter() {
        
    }
    
    func save() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
