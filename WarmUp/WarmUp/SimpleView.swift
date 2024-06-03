//
//  SimpleView.swift
//  WarmUp
//
//  Created by Yumin Chu on 6/3/24.
//

import SwiftUI

struct SimpleView: View {
  var body: some View {
    VStack {
      Image(systemName: "pencil")
        .resizable()
        .scaledToFit()
        .frame(width: 200, height: 200)
      
      Text("헤드라인 입니다")
        .font(.headline)
        .fontWeight(.bold)
        .padding()
      
      Text("서브헤드라인 입니다")
        .font(.subheadline)
        .padding()
      
      Text("바디 입니다")
        .font(.body)
        .padding()
      
      Button {
        print("Click Me")
      } label: {
        Text("Click Me")
          .foregroundColor(.white)
          .fontWeight(.bold)
          .padding()
          .background(Color.blue)
          .clipShape(RoundedRectangle(cornerRadius: 10))
      }
    }
  }
}

#Preview {
  SimpleView()
}
