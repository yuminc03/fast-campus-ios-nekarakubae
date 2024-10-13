import SwiftUI

struct CustomNavigationBar: View {
  private let isDisplayLeftButton: Bool
  private let isDisplayRightButton: Bool
  private let leftButtonAction: () -> Void
  private let rightButtonAction: () -> Void
  private let rightButtonType: NavigationButtonType
  
  init(
    isDisplayLeftButton: Bool,
    isDisplayRightButton: Bool,
    leftButtonAction: @escaping () -> Void,
    rightButtonAction: @escaping () -> Void,
    rightButtonType: NavigationButtonType
  ) {
    self.isDisplayLeftButton = isDisplayLeftButton
    self.isDisplayRightButton = isDisplayRightButton
    self.leftButtonAction = leftButtonAction
    self.rightButtonAction = rightButtonAction
    self.rightButtonType = rightButtonType
  }
  
  var body: some View {
    HStack {
      if isDisplayLeftButton {
        Button(action: leftButtonAction) {
          Image(.leftArrow)
        }
      }
      
      Spacer()
      
      if isDisplayRightButton {
        Button(action: rightButtonAction) {
          switch rightButtonType {
          case .close:
            Image(.close)
            
          case .edit, .complete, .create:
            Text(rightButtonType.rawValue)
              .foregroundColor(.customBlack)
          }
        }
      }
    }
    .padding(.horizontal, 20)
    .frame(height: 20)
  }
}

#Preview {
  CustomNavigationBar(
    isDisplayLeftButton: true,
    isDisplayRightButton: true,
    leftButtonAction: { },
    rightButtonAction: { },
    rightButtonType: .close
  )
}
