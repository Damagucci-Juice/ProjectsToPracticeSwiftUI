//
//  LargeImage.swift
//  BrainGame
//
//  Created by YEONGJIN JANG on 2022/10/15.
//

import SwiftUI

struct LargeImage: View {
    let source: String

    var body: some View {
        Image(source)
            .resizable()
            .frame(width: 150, height: 150)
            .foregroundColor(.black)
    }
}
