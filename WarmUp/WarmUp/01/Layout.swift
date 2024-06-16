//
//  Layout.swift
//  WarmUp
//
//  Created by Yumin Chu on 6/16/24.
//

import SwiftUI

struct Layout: View {
  var body: some View {
    VStack {
      Image(systemName: "pencil")
        .resizable()
        .scaledToFit()
        .frame(width: 200, height: 200)
        .padding()
      
      Text("Text Element 1")
        .font(.headline)
        .padding()
      
      Text("Text Element 2")
        .font(.subheadline)
        .padding()
      
      Text("Text Element 3")
        .font(.body)
        .padding()
      
      HStack {
        MyButton(buttonTitle: "Button 1", ButtonColor: .blue)
        
        MyButton(buttonTitle: "Button 2", ButtonColor: .green)
      }
      
      Button {
        
      } label: {
        VStack {
          Image(systemName: "arrow.right.circle.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 50)
          Text("Complex Button")
        }
        .foregroundColor(.white)
        .padding()
        .background(.orange)
        .clipShape(RoundedRectangle(cornerRadius: 10))
      }
    }
  }
}

#Preview {
  Layout()
}
