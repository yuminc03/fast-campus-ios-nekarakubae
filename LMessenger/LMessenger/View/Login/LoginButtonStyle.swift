import SwiftUI

struct LoginButtonStyle: ButtonStyle {
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.system(size: 14))
      .foregroundStyle(.lineApp)
      .frame(maxWidth: .infinity, maxHeight: 40)
      .overlay {
        RoundedRectangle(cornerRadius: 5)
          .stroke(Color.lineApp, lineWidth: 0.8)
      }
      .padding(.horizontal, 15)
      .opacity(configuration.isPressed ? 0.5 : 1)
  }
}
