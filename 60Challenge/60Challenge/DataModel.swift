//
//  DataModel.swift
//  60Challenge
//
//  Created by Gucci on 2023/06/04.
//

import Foundation

class DataModel: ObservableObject {
    
    @Published var users: [User] = []
    let dataConverter: DataConverter
    
    init(dataConverter: DataConverter) {
        self.dataConverter = dataConverter
        Task {
            if let users = try? await loadUser() {
                self.users = users
            }
        }
    }
    
}

func loadUser() async throws -> [User] {
    guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else { throw NetworkError.urlInvalid }
    
    let data: Data
    
    do {
        let (remoteData, _) = try await URLSession.shared.data(from: url)
        data = remoteData
    } catch {
        throw NetworkError.fetchFailed
    }
    
    do {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let users = try decoder.decode([User].self, from: data)
        return users
    } catch {
        throw NetworkError.decodingFailed
    }
    
}


enum NetworkError: Error {
    case urlInvalid
    case fetchFailed
    case decodingFailed
}
