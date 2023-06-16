//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Gucci on 2023/06/16.
//

import MapKit
import SwiftUI

extension ContentView {
    
    @MainActor
    class ViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(center: .init(latitude: 50, longitude: 0), span: .init(latitudeDelta: 25, longitudeDelta: 25))
        @Published private(set) var locations: [Location]
        @Published var selectedPlace: Location?
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func addLocation() {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            locations.append(newLocation)
        }
        
        func update(location: Location) {
            guard let selectedPlace else { return }
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to svae data")
            }
        }
    }
}
