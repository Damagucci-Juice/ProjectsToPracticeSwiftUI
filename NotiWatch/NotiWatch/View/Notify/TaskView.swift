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
                Text("๐ ์ฝ๋จน๊ธฐ")
                    .font(.title)
                Spacer()
                Text("1ํ")
            }
            Text("21:00 ์๋ฆผ์์ ")
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
