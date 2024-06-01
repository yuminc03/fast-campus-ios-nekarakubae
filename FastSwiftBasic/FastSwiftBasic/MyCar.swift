//
//  MyCar.swift
//  FastSwiftBasic
//
//  Created by Yumin Chu on 5/30/24.
//

import SwiftUI

struct MyCar: View {
  var myCar = KIA()
  var broCar = Hyundai()
  var cars: [Driveable] = [KIA(), Hyundai()]
  
  @State var speed = 20
  
  var body: some View {
    VStack {
      Text("Speed: \(speed)")
      Button {
        speed = broCar.speedDown(with: speed)
        cars.randomElement()?.speedDown(with: speed)
      } label: {
        Text("감속")
      }
    }
  }
}

struct KIA: Driveable {
  func speedDown(with speed: Int) -> Int {
    print("속도가 5 줄어듦")
    return speed - 5
  }
}

struct Hyundai: Driveable {
  func speedDown(with speed: Int) -> Int {
    print("속도가 9 줄어듦")
    return speed - 9
  }
}

protocol Driveable {
  func speedDown(with speed: Int) -> Int
}

#Preview {
  MyCar()
}
