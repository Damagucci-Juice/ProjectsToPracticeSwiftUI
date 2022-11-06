//
//  SmallTitle.swift
//  MoonShot
//
//  Created by YEONGJIN JANG on 2022/11/07.
//

import SwiftUI

struct SmallTitle: ViewModifier {
    func body(content: Content) ->  some View {
        content
            .font(.title.bold())
            .padding(.bottom, 5)
    }
}

extension View {
    func smallTitle() -> some View {
        modifier(SmallTitle())
    }
}
