import SwiftUI

struct AuthenticatedView: View {
  @StateObject var vm: AuthenticationVM
  
  var body: some View {
    switch vm.authenticationState {
    case .unauthenticated:
      // login
      EmptyView()
    case .authenticated:
      // mainTab
      EmptyView()
    }
  }
}

#Preview {
  AuthenticatedView(vm: .init(container: .init(services: StubService())))
}
