//
//  Sample.swift
//  FastSwiftBasic
//
//  Created by Yumin Chu on 5/29/24.
//

import SwiftUI

struct Sample: View {
  let data = [
    Destination(
      direction: .north,
      food: "pasta",
      image: Image(systemName: "carrot")
    ),
    Destination(
      direction: .east,
      food: nil,
      image: Image(systemName: "sunrise")
    ),
    Destination(
      direction: .west,
      food: nil,
      image: Image(systemName: "balloon")
    ),
    Destination(
      direction: .south,
      food: "IceCream",
      image: Image(systemName: "takeoutbag.and.cup.and.straw")
    )
  ]
  @State var selectedDestination: Destination?
  
  var body: some View {
    VStack {
      selectedDestination?.image
        .resizable()
        .scaledToFit()
        .frame(width: 200, height: 200)
      
      if let destination = selectedDestination {
        Text(destination.direction.rawValue)
        
        if let food = destination.food {
          Text(food)
        }
      }
      
      Button {
        selectedDestination = data.randomElement()
      } label: {
        Text("Click!")
      }
    }
  }
}

struct Destination {
  let direction: Direction
  let food: String?
  let image: Image
}

enum Direction: String {
  case east = "동"
  case west = "서"
  case south = "남"
  case north = "북"
}

#Preview {
  Sample()
}
