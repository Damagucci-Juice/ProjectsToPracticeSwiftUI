//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Gucci on 2023/06/16.
//

import MapKit
import SwiftUI
import LocalAuthentication

extension ContentView {
    
//    @MainActor
    class ViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(center: .init(latitude: 50, longitude: 0), span: .init(latitudeDelta: 25, longitudeDelta: 25))
        @Published private(set) var locations: [Location]
        @Published var selectedPlace: Location?
        @Published var isUnlocked = false
        @Published var onError = false
        @Published var noBiometry = false
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
        let locationFetcher = LocationFetcher()
        
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
            save()
        }
        
        func update(newLocation: Location) {
            guard let selectedPlace else { return }
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = newLocation
                save()
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
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if success {
                        Task { @MainActor in
                            self.isUnlocked = true
                        }
                    } else {
                        // error
                        Task { @MainActor in
                            self.onError = true
                        }
                    }
                }
            } else {
                // no biometrics
                Task { @MainActor in
                    self.noBiometry = true 
                }
            }
            
        }
        
        func getUserCurrentLocation() {
//            self.locationFetcher.start()
        
            if let location = self.locationFetcher.lastKnownLocation {
                mapRegion = MKCoordinateRegion(center: location, span: .init(latitudeDelta: 25, longitudeDelta: 25))
                print("location updated")
            } else {
                print("not location yet")
            }
        }
    }
}
