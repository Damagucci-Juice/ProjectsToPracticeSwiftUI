//
//  Prospects.swift
//  HotProspects
//
//  Created by Gucci on 2023/06/18.
//

import SwiftUI

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    private let saveKey = "savedData"
    private let fileName = "contactFile"
    
    init() {
        do {
            let file = try FileManager.default.url(for: .documentDirectory,
                                                   in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(fileName)
            let data = try Data(contentsOf: file)
            let decoded = try JSONDecoder().decode([Prospect].self, from: data)
            people = decoded
        } catch {
            self.people = []
        }
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    func add(prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func sortByName() {
        people = people.sorted { p1, p2 in
            p1.name < p2.name
        }
    }
    
    func sortByDate() {
        people = people.sorted { p1, p2 in
            p1.added < p2.added
        }
    }
    
    private func save() {
        
        if let peopleData = try? JSONEncoder().encode(people),
           let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = url.appendingPathComponent(fileName)
            
            do {
                try peopleData.write(to: path)
            } catch {
                print("Saving using by file manager failed.")
            }
        }
    }
}




class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var added = Date()
    fileprivate(set) var isContacted = false
}
