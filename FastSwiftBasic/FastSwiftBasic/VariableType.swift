//
//  VariableType.swift
//  FastSwiftBasic
//
//  Created by Yumin Chu on 5/14/24.
//

import SwiftUI

struct VariableType: View {
  var name: String = "Lonalia"
  var age: Int = 22
  var height: Float = 160
  var weight: Double = 47.0
  var havePat: Bool = false
  
  var body: some View {
    VStack {
      Text("\(name)")
      Text("\(age)")
      Text("\(height)")
      Text("\(weight)")
      Text("\(havePat.description)") // Bool을 글자 표현으로 변환
    }
  }
}

#Preview {
  VariableType()
}
