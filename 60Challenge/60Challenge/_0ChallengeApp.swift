//
//  _0ChallengeApp.swift
//  60Challenge
//
//  Created by Gucci on 2023/06/04.
//

import SwiftUI

@main
struct _0ChallengeApp: App {
    let controller = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView(model: DataModel(dataConverter: DataConverter(context: controller.container.viewContext)))
                .environment(\.managedObjectContext,
                              controller.container.viewContext)
        }
    }
}
