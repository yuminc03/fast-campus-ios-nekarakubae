import SwiftUI

struct AuthenticatedView: View {
  @StateObject var vm: AuthenticationVM
  
  var body: some View {
    switch vm.authenticationState {
    case .unauthenticated:
      LoginIntroView()
        .environmentObject(vm)
      
    case .authenticated:
      MainTabView()
    }
  }
}

#Preview {
  AuthenticatedView(vm: .init(container: .init(services: StubService())))
}
