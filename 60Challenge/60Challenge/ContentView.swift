//
//  ContentView.swift
//  60Challenge
//
//  Created by Gucci on 2023/06/04.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model: DataModel
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationView {
            List(model.users) { user in
                NavigationLink {
                    EmptyView()
                } label: {
                    UserRow(user: user)
                }
            }
            .navigationTitle("Contact")
        }
    }
}
