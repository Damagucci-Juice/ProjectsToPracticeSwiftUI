//
//  DataModel.swift
//  60Challenge
//
//  Created by Gucci on 2023/06/04.
//

import Foundation

class DataModel: ObservableObject {
    
    static let shared = DataModel()
    
    @Published var users: [User] = []
    
    init() {
        Task {
            if let users = try? await loadUser() {
                self.users = users
            }
        }
    }
    
}

func loadUser() async throws -> [User] {
    guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else { throw NetworkError.urlInvalid }
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let users = try decoder.decode([User].self, from: data)
            return users
        } catch {
            throw NetworkError.decodingFailed
        }
    } catch {
        throw NetworkError.fetchFailed
    }
}


enum NetworkError: Error {
    case urlInvalid
    case fetchFailed
    case decodingFailed
}
