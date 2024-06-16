//
//  MyButton.swift
//  WarmUp
//
//  Created by Yumin Chu on 6/16/24.
//

import SwiftUI

struct MyButton: View {
  private var buttonTitle: String
  private var ButtonColor: Color
  
  init(buttonTitle: String, ButtonColor: Color) {
    self.buttonTitle = buttonTitle
    self.ButtonColor = ButtonColor
  }
  
  var body: some View {
    Button {
      
    } label: {
      Text(buttonTitle)
        .padding()
        .background(ButtonColor)
        .foregroundColor(.white)
        .font(.headline)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
  }
}

#Preview {
  MyButton(buttonTitle: "Button 1", ButtonColor: .black)
}
