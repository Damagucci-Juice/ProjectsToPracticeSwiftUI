//
//  ContentView.swift
//  60Challenge
//
//  Created by Gucci on 2023/06/04.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var model = DataModel.shared
    
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
