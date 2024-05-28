//
//  Nil.swift
//  FastSwiftBasic
//
//  Created by Yumin Chu on 5/28/24.
//

import SwiftUI

struct Nil: View {
  
  var name: String = "Lonalia" // 꼭 있어야 할 경우
  var petName: String? = "없음" // 있을 수도 없을 수도 있을 경우
  
  var bami: String = "Bami"
  var petName2: String = "coco"
  
  var body: some View {
    VStack {
      Text("이름은 \(name), 팻 이름은 \(petName)입니다.")
      Text("이름은 \(bami), 팻 이름은 \(petName2)입니다.")
    }
    .onAppear {
      // 이름은 Lonalia, 팻 이름은 Optional("없음")입니다.
      print("이름은 \(name), 팻 이름은 \(petName)입니다.")
      // 이름은 Bami, 팻 이름은 coco입니다.
      print("이름은 \(bami), 팻 이름은 \(petName2)입니다.")
    }
  }
}

#Preview {
  Nil()
}
