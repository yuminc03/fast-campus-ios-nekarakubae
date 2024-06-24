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
  @State private var favoriteFruits: [Fruit] = [
    .init(name: "Apple", matchFruitName: "Banana", price: 1000),
    .init(name: "Banana", matchFruitName: "Banana", price: 3000),
    .init(name: "Double Kiwi", matchFruitName: "Elder berry", price: 2400),
    .init(name: "Elder berry", matchFruitName: "Double Kiwi", price: 8000)
  ]
  
  @State private var fruitName = ""
  
  var body: some View {
    NavigationStack {
      VStack {
        HStack {
          TextField("insert fruit name", text: $fruitName)
          Button {
            favoriteFruits.append(.init(
              name: fruitName,
              matchFruitName: "Apple",
              price: 1000
            ))
          } label: {
            Text("insert")
              .padding()
              .background(.blue)
              .foregroundColor(.white)
              .clipShape(RoundedRectangle(cornerRadius: 10))
          }
        }
      }        
      .padding()

      
      List {
        ForEach(favoriteFruits, id: \.self) { fruit in
          VStack(alignment: .leading) {
            Text("name: \(fruit.name)")
            Text("metchFruitName: \(fruit.matchFruitName)")
            Text("price: \(fruit.price)")
          }
        }.onDelete { indexSet in
          favoriteFruits.remove(atOffsets: indexSet)
        }
      }
      .navigationTitle("Fruit List")
    }
  }
}

#Preview {
  ListLoop()
}
