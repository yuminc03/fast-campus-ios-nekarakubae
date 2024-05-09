//
//  ContentView.swift
//  FastSwiftBasic
//
//  Created by Yumin Chu on 5/9/24.
//

import SwiftUI

struct ContentView: View {
  
  var name: String = "유민"
  
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("\(name)님 안녕하세요!")
      Text("\(name)님의 포인트는 1000점 입니다.")
      Text("\(name)님의 포인트는 1000점 입니다.")
      Text("\(name)님 반가워요!")
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
