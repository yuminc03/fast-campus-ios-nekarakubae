//
//  ListLoop.swift
//  WarmUp
//
//  Created by Yumin Chu on 6/20/24.
//

import SwiftUI

struct Fruit: Hashable {
  let name: String
  let matchFruitName: String
  let price: Int
}

struct ListLoop: View {
  // 데이터의 틀을 만들어서 가독성 상승
  private let favoriteFruits: [Fruit] = [
    .init(name: "Apple", matchFruitName: "Banana", price: 1000),
    .init(name: "Banana", matchFruitName: "Banana", price: 3000),
    .init(name: "Double Kiwi", matchFruitName: "Elder berry", price: 2400),
    .init(name: "Elder berry", matchFruitName: "Double Kiwi", price: 8000)
  ]
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(favoriteFruits, id: \.self) { fruit in
          VStack(alignment: .leading) {
            Text("name: \(fruit.name)")
            Text("metchFruitName: \(fruit.matchFruitName)")
            Text("price: \(fruit.price)")
          }
        }
      }
      .navigationTitle("Fruit List")
    }
  }
}

#Preview {
  ListLoop()
}
