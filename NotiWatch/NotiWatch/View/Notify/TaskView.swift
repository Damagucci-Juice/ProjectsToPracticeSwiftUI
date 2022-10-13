//
//  TaskView.swift
//  NotiWatch
//
//  Created by YEONGJIN JANG on 2022/10/12.
//

import SwiftUI

struct TaskView: View {
    var body: some View {
        VStack(alignment: .trailing, spacing: 50) {
            HStack {
                Text("💊 약먹기")
                    .font(.title)
                Spacer()
                Text("1회")
            }
            Text("21:00 알림예정")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct MissionRowItem_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
    }
}
