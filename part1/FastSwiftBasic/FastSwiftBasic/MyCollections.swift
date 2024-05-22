//
//  MyCollections.swift
//  FastSwiftBasic
//
//  Created by Yumin Chu on 5/22/24.
//

import SwiftUI

struct MyCollections: View {
  
  var foods: [String] = ["egges", "banaans", "beans"]
  var jazzs: Set<String> = ["bibidudu", "labdap", "dididudu"]
  var hiphop: Set<String> = ["labdap", "rap", "wow"]
  var koEngDict: [String: String] = ["사과": "Apple", "바나나": "Banana"]
  
  var body: some View {
    VStack {
      Text(hiphop.intersection(jazzs).description)

      Button {
        print(hiphop.intersection(jazzs).description)
      } label: {
        Text("hit!")
      }
      
      Text(foods[0])
      Text(foods[2])
      
      Text(koEngDict["사과"]!)
      Text(koEngDict["바나나"]!)
    }
  }
}

#Preview {
  MyCollections()
}
