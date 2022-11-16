//
//  ActivityDetailView.swift
//  HabitTracker
//
//  Created by YEONGJIN JANG on 2022/11/16.
//

import SwiftUI

struct ActivityDetailView: View {
    @ObservedObject var viewModel: MainViewModel
    @State var completionCount: Int = 0
    let activity: Activity

    init(activity: Activity, viewModel: MainViewModel) {
        self.viewModel = viewModel
        self.activity = activity
    }

    var body: some View {
        VStack(alignment: .leading) {

            Text(activity.title)
                .font(.title)

            Divider()


            Text("Description")
                .font(.title2)
                .padding(.top, 30)

            Divider()

            Text(activity.description)

            HStack {
                Text(completionCount, format: .number)
                Spacer()
                Button("Increment Completion Count") {
                    completionCount += 1
                }
            }
            .padding(.top, 30)

            Spacer()
        }
        .padding(.horizontal)
        .onAppear {
            completionCount = activity.completionCount
        }
        .onDisappear {
            viewModel.update(activity, completionCount)
        }
    }
}
