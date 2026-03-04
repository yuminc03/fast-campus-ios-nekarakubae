import Foundation
import Combine

final class DIContainer: ObservableObject {
  var services: ServiceType
  
  init(services: ServiceType) {
    self.services = services
  }
  
}
