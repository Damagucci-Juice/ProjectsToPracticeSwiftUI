//
//  ThickDivider.swift
//  MoonShot
//
//  Created by YEONGJIN JANG on 2022/11/07.
//

import SwiftUI

struct ThickDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}

struct ThickDivider_Previews: PreviewProvider {
    static var previews: some View {
        ThickDivider()
    }
}
