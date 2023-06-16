//
//  ContentView.swift
//  BucketList
//
//  Created by Gucci on 2023/06/15.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State private var mapRegion = MKCoordinateRegion(center: .init(latitude: 50, longitude: 0), span: .init(latitudeDelta: 25, longitudeDelta: 25))
    @State private var locations = [Location]()
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                MapMarker(coordinate: .init(latitude: location.latitude, longitude: location.longitude))
            }
                .ignoresSafeArea()
            Circle()
                .fill(.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        // add new location
                        locations.append(addNewLocation())
                    } label: {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
    }
    
    func addNewLocation() -> Location {
        return Location(id: UUID(), name: "NewLocation", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
