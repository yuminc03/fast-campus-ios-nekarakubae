//
//  Condition.swift
//  FastSwiftBasic
//
//  Created by Yumin Chu on 5/22/24.
//

import SwiftUI

struct Condition: View {
  var count = 2
  var hasLoggined = true
  
  var body: some View {
    if count > 4 {
      Text("숫자는 4보다 큽니다.")
    } else {
      Text("숫자는 4보다 같거나 작습니다.")
    }
    
    if hasLoggined {
      Text("로그아웃 하시겠습니까?")
    } else {
      Text("로그인 하시겠습니까?")
    }
    
//    guard hasLoggined else {
//      Text("로그인 하시겠습니까?")
//    }
//    
//    Text("로그아웃 하시겠습니까?")
  }
}

#Preview {
  Condition()
}
