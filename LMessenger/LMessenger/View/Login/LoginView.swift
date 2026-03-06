import SwiftUI

struct LoginView: View {
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var authVM: AuthenticationVM
  
  var body: some View {
    VStack(alignment: .leading) {
      Group {
        Text("로그인")
          .font(.system(size: 28, weight: .bold))
          .foregroundStyle(.bkText)
          .padding(.top, 80)
        
        Text("아래 제공되는 서비스로 로그인을 해주세요.")
          .font(.system(size: 14))
          .foregroundStyle(.greyDeep)
      }
      .padding(.horizontal, 30)
      
      Spacer()
      
      Button {
        authVM.send(action: .googleLogin)
      } label: {
        Text("Google로 로그인")
      }
      .buttonStyle(LoginButtonStyle(
        textColor: .bkText,
        borderColor: .greyLight
      ))
      
      Button {
        
      } label: {
        Text("Apple로 로그인")
      }
      .buttonStyle(LoginButtonStyle(
        textColor: .bkText,
        borderColor: .greyLight
      ))
    }
    .navigationBarBackButtonHidden()
    .toolbar {
      ToolbarItemGroup(placement: .navigationBarLeading) {
        Button {
          dismiss()
        } label: {
          Image(.back)
        }
      }
    }
  }
}

#Preview {
  LoginView()
}
