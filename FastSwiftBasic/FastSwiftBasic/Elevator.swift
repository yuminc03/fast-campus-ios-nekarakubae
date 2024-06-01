//
//  Elevator.swift
//  FastSwiftBasic
//
//  Created by Yumin Chu on 5/26/24.
//

import SwiftUI

struct Elevator: View {
  @State var myElevator = ElevatorStruct()
  
  var body: some View {
    VStack {
      Text("층수: \(myElevator.level)")
      
      HStack {
        Button {
          myElevator.goDown()
        } label: {
          Text("아래")
        }
        
        Button {
          myElevator.goUp()
        } label: {
          Text("위로")
        }
      }
    }
  }
}

struct ElevatorStruct {
  // 층 수를 표시해주는 display
  var level: Int = 1
  
  // 위로 올라갈 수 있음
  mutating func goDown() {
    level = level - 1
  }
  
  // 아래로 내려갈 수 있음
  mutating func goUp() {
    level = level + 1
  }
}

#Preview {
  Elevator()
}
