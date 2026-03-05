import Foundation
import Combine

enum AuthenticationState {
  case unauthenticated
  case authenticated
}

final class AuthenticationVM: ObservableObject {
  @Published private(set) var authenticationState: AuthenticationState = .unauthenticated
  
  private var container: DIContainer
  
  init(container: DIContainer) {
    self.container = container
  }
}
