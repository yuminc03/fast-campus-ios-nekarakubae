import SwiftUI

@main
struct VoiceMemoApp: App {
  // SwiftUI에서 UIKit - AppDelegate를 생성하는데 사용하는 property wrapper
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    WindowGroup {
      OnboardingView()
    }
  }
}
