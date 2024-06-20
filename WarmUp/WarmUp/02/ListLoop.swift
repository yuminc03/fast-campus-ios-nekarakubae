//
//  ListLoop.swift
//  WarmUp
//
//  Created by Yumin Chu on 6/20/24.
//

import SwiftUI

struct ListLoop: View {
  private let fruits = ["Apple", "Banana", "Cherry", "Double Kiwi", "Elder berry"]
  private let price = ["1000", "3000", "4000", "2400", "8000"]
  private var count = 0
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(fruits, id: \.self) { fruit in
          HStack {
            Text(fruit)
            Text(price[count])
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
