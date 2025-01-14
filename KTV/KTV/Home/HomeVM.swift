import Foundation

@MainActor
final class HomeVM {
  private(set) var home: Home?
  var dataChanged: (() -> Void)?
  
  func requestData() {
    Task {
      do {
        self.home = try await DataLoader.load(url: URLDefines.home, for: Home.self)
        self.dataChanged?()
      } catch {
        print("JSON Parsing Failed: \(error.localizedDescription)")
      }
    }
  }
}
