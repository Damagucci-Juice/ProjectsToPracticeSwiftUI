//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Gucci on 2023/06/17.
//

import SwiftUI

extension EditView {
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @MainActor
    class ViewModel: ObservableObject {
        let location: Location
        @Published var name: String
        @Published var description: String
        @Published var loadingState = LoadingState.loading
        @Published var pages = [Page]()

        init(location: Location, loadingState: LoadingState = LoadingState.loading, pages: [Page] = [Page]()) {
            self.location = location
            self.name = location.name
            self.description = location.description
            self.loadingState = loadingState
            self.pages = pages
        }
        
        func saveNewLocation() -> Location {
            var newLocation = location
            newLocation.id = UUID()
            newLocation.name = name
            newLocation.description = description
            return newLocation
        }
        
        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)

                // we got some data back!
                let items = try JSONDecoder().decode(Result.self, from: data)

                // success – convert the array values to our pages array
                pages = items.query.pages.values.sorted()
                loadingState = .loaded
            } catch {
                // if we're still here it means the request failed somehow
                loadingState = .failed
            }
        }
    }
}
