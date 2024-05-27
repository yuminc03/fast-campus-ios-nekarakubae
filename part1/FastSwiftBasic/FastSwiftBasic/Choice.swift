//
//  Choice.swift
//  FastSwiftBasic
//
//  Created by Yumin Chu on 5/27/24.
//

import SwiftUI

struct Choice: View {
  var direction: Direction = .east
  var member: Member = .yumin
  var menu: Menu = .steak(5)
  
  var body: some View {
    Text("방향은 \(direction.rawValue)쪽 입니다.")
  }
}

enum Member: String {
  case yumin = "유민"
  case RM, Jin, Suga, JHope, Jimin, V, JungKook
}

enum Menu {
  case pasta
  case pizza
  case steak(Int)
}

enum Direction: String {
  case east = "동"
  case west = "서"
  case south = "남"
  case north = "북"
}

#Preview {
  Choice()
}
