//
//  Loop.swift
//  FastSwiftBasic
//
//  Created by Yumin Chu on 5/23/24.
//

import SwiftUI

struct Loop: View {
  let names: [String] = ["랩몬스터", "진", "슈가", "제이홉", "지민", "뷔", "정국"]
  
  var body: some View {
    // 하나에 이름들을 하나씩 다 쓰려면 같은 코드가 반복되어 복잡함
//    VStack {
//      Text("first")
//      Text("second")
//      Text("third")
//      Text("fourth")
//      Text("fifth")
//    }
    
    VStack {
      ForEach(names, id: \.self) { item in
        Text(item)
      }
    }
  }
}

#Preview {
  Loop()
}
