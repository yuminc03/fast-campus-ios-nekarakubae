import SwiftUI

@main
struct LMessengerApp: App {
  @StateObject private var container: DIContainer = .init(services: Services())
  
  var body: some Scene {
    WindowGroup {
      AuthenticatedView(vm: .init())
        .environmentObject(container)
    }
  }
}
