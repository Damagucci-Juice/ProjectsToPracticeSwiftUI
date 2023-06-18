//
//  ContentView.swift
//  HotProspects
//
//  Created by Gucci on 2023/06/18.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.sound,.alert,.badge]) { isSuccess, error in
                    if isSuccess {
                        print("Succes")
                    } else if let error = error {
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.body = "It looks hungry"
                content.sound = .default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
