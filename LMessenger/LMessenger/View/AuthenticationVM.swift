import Foundation
import Combine

final class AuthenticationVM: ObservableObject {
  private var container: DIContainer
  
  init(container: DIContainer) {
    self.container = container
  }
}
