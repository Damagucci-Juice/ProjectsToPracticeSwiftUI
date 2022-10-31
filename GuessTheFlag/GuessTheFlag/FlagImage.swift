//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by YEONGJIN JANG on 2022/10/15.
//

import SwiftUI

struct FlagImage: View {
    let country: String

    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
        
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(country: "US")
    }
}
