//
//  Half.swift
//  FastSwiftBasic
//
//  Created by Yumin Chu on 5/25/24.
//

import SwiftUI

struct Half: View {
  var name: String = "Lonalia"
  var age: Int = 22
  var names: [String] = ["로나리아", "가브리엘", "케이트", "제이"]
  
  var body: some View {
//    VStack {
//      HStack {
//        Text("\(name)입니다.")
//        Image(systemName: "pencil")
//      }
//      Text("안녕하세요. \(age)살의 \(name).")
//    }
    
    List {
      ForEach(names, id: \.self) { name in
        var welcome = sayHi(to: name)
        if welcome == "로나리아" {
          Text("기다렸어요.! \(name)님 반갑습니다.")
        } else {
          Text(welcome)
        }
        Text(name)
      }
    }
  }
  
  private func sayHi(to name: String) -> String {
    return "\(name)님 반갑습니다."
  }
}

#Preview {
  Half()
}
