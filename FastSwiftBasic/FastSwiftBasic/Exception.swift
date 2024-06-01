//
//  Exception.swift
//  FastSwiftBasic
//
//  Created by Yumin Chu on 5/29/24.
//

import SwiftUI

struct Exception: View {
  @State var inputNumber = ""
  @State var resultNumber: Float = 0
  
  var body: some View {
    VStack {
      TextField("나눌 숫자를 입력해주세요", text: $inputNumber)
      Text("나눈 결과는 다음과 같습니다. \(resultNumber)")
      Button {
        do {
          try resultNumber = devideTen(with: Float(inputNumber) ?? 1.0)
        } catch DivideError.dividedError {
          print("0으로 나눔")
          resultNumber = -99
        } catch {
          print(error.localizedDescription)
        }
      } label: {
        Text("나누기")
      }
    }
  }
  
  func devideTen(with inputNumber: Float) throws -> Float {
    var result: Float = 0
    if inputNumber == 0 {
      throw DivideError.dividedError
    } else {
      result = 10 / inputNumber
    }
    
    return result
  }
}

enum DivideError: Error {
  case dividedError
}

#Preview {
  Exception()
}
