//
//  Function.swift
//  FastSwiftBasic
//
//  Created by Yumin Chu on 5/25/24.
//

import SwiftUI

struct Function: View {
  @State private var inputNumber: Int = 4
  
  var body: some View {
    VStack {
      Text("Input number is \(inputNumber)")
      
      Button {
        inputNumber = plusFive(with: inputNumber)
      } label: {
        Text("+ 5")
      }
    }
  }
  
  private func plusFive(with input: Int) -> Int {
    return input + 5
  }
}

#Preview {
  Function()
}
