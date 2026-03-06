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
  
  var userID: String?
  
  private var container: DIContainer
  private var cancelBag = Set<AnyCancellable>()
  
  init(container: DIContainer) {
    self.container = container
  }
  
  func send(action: Action) {
    switch action {
    case .googleLogin:
      container.services.authService.signInWithGoogle()
        .sink { completion in
          // TODO: -
        } receiveValue: { [weak self] user in
          self?.userID = user.id
        }
        .store(in: &cancelBag)

    }
  }
}
