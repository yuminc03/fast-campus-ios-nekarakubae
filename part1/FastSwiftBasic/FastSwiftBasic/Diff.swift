//
//  Diff.swift
//  FastSwiftBasic
//
//  Created by Yumin Chu on 5/26/24.
//

import SwiftUI

struct Diff: View {
  let myCar = Car(name: "리어카", owner: "yumin")
  @ObservedObject var myCarClass = CarClass(name: "리어카2", owner: "yumin2")
  
  var body: some View {
    VStack {
      Text("\(myCarClass.name)의 주인은 \(myCarClass.owner)입니다.")
      Button {
        let broCar = myCarClass
        broCar.name = "car"
        broCar.owner = "noname"
        
        myCar.sayHi()
      } label: {
        Text("출발")
      }
    }
  }
}

struct Car {
  let name: String
  let owner: String
  
  func sayHi() {
    print("hi \(owner)")
  }
}


class CarClass: ObservableObject {
  @Published var name: String
  @Published var owner: String
  
  init(name: String, owner: String) {
    self.name = name
    self.owner = owner
  }
  
  func sayHi() {
    print("hi \(owner)")
  }
}

#Preview {
  Diff()
}
