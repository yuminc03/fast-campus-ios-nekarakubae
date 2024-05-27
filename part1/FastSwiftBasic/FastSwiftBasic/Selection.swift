//
//  Selection.swift
//  FastSwiftBasic
//
//  Created by Yumin Chu on 5/27/24.
//

import SwiftUI

struct Selection: View {
  @State var myDirection: Direction = .south
  
  var body: some View {
    switch myDirection {
    case .east:
      Text("\(myDirection.rawValue)쪽으로 해뜨는 것을 보러가요.")
      
    case .west:
      Text("\(myDirection.rawValue)쪽으로 석양을 보러 갈까요?")
      
    case .south:
      Text("\(myDirection.rawValue)쪽은 따뜻합니다.")
      
    case .north:
      Text("\(myDirection.rawValue)쪽은 춥습니다.")
    }
    
    Button {
      // if문은 예외등을 처리하는 느낌?
      // switch, if문은 가독성의 차이가 있음
      // 상황에 맞는 것을 선택하는 것이 중요함
      
//      if myDirection == .north {
//        myDirection = .east
//      } else if myDirection == .east {
//        myDirection = .south
//      } else if myDirection == .west {
//        myDirection = .north
//      }
      
      switch myDirection {
      case .east:
        myDirection = .south
        
      case .west:
        myDirection = .north
        
      case .south:
        myDirection = .west
        
      case .north:
        myDirection = .east
        
//       default: // default를 사용할 때는 조심! (case에 해당 안되면 다 여기로 빠짐)
//        print("에러입니다.")
      }
    } label: {
      Text("돌리기")
    }
  }
}

#Preview {
  Selection()
}
