//
//  CheckoutView.swift
//  Cupcake Corner
//
//  Created by YEONGJIN JANG on 2022/11/20.
//

import SwiftUI

struct CheckoutView: View {
    @Binding var order: Order

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                        image
                            .resizable()
                            .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)

                Button("Place Order", action: { })
                    .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    @State static var order = Order()
    static var previews: some View {
        CheckoutView(order: $order)
    }
}
