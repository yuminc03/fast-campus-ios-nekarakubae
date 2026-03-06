import Foundation
import Combine

enum AuthenticationState {
  case unauthenticated
  case authenticated
}

final class AuthenticationVM: ObservableObject {
  enum Action {
    case googleLogin
  }
  
  @Published private(set) var authenticationState: AuthenticationState = .unauthenticated
  
  private var container: DIContainer
  
  init(container: DIContainer) {
    self.container = container
  }
  
  func send(action: Action) {
    switch action {
    case .googleLogin:
      // TODO: - 
      return
      
      
    }
  }
}
