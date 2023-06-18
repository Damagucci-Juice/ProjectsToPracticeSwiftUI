//
//  ContentView.swift
//  HotProspects
//
//  Created by Gucci on 2023/06/18.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Image("example")
//            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(.black)
            .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
