//
//  ContentView.swift
//  BucketList
//
//  Created by Gucci on 2023/06/15.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
    @State private var mapRegion = MKCoordinateRegion(center: .init(latitude: 51.5, longitude: -0.12), span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    
    enum LoadingState {
        case loading, success, failed
    }
    
    struct LoadingView: View {
        var body: some View {
            Text("Loading...")
        }
    }

    struct SuccessView: View {
        var body: some View {
            Text("Success!")
        }
    }

    struct FailedView: View {
        var body: some View {
            Text("Failed.")
        }
    }
    
    @State private var loadingState = LoadingState.loading
    
    var body: some View {
        NavigationView {
            VStack {
                if loadingState == .loading {
                    LoadingView()
                } else if loadingState == .success {
                    SuccessView()
                } else if loadingState == .failed {
                    FailedView()
                }
                
                Spacer()
                
                Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        NavigationLink {
                            Text(location.name)
                        } label: {
                            Circle()
                                .stroke(.red, lineWidth: 3)
                                .frame(width: 44, height: 44)
                        }
                    }
                }
                
                Button("Next State", action: nextState)
            }
        }
    }
    
    func nextState() {
        switch loadingState {
        case .loading:
            let isSuccess = Bool.random()
            loadingState = isSuccess ? .success : .failed
        case .failed, .success:
            loadingState = .loading
        }
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
