//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Gucci on 2023/06/03.
//

import SwiftUI
import CoreData

enum Predicate {
    case beginsWith
    
    var text: String {
        switch self {
        case .beginsWith:
            return "BEGINSWITH"
        }
    }
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>

    let content: (T) -> Content
    
    init(predicate: Predicate, sortDescriptors: [NSSortDescriptor],filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(predicate.text) %@", filterKey, filterValue))
        self.content = content
    }

    var body: some View {
        List(fetchRequest, id: \.self) { singer in
            self.content(singer)
        }
    }

}
