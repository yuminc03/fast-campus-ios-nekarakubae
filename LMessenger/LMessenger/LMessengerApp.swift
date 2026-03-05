import SwiftUI

@main
struct LMessengerApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  @StateObject private var container: DIContainer = .init(services: Services())
  
  var body: some Scene {
    WindowGroup {
      AuthenticatedView(vm: .init(container: container))
        .environmentObject(container)
    }
  }
}
