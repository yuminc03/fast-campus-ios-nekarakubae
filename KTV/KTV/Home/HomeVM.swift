import Foundation

@MainActor
final class HomeVM {
  private(set) var home: Home?
  
  let recommendVM: HomeRecommendVM = .init()
  var dataChanged: (() -> Void)?
  
  func requestData() {
    Task {
      do {
        let home = try await DataLoader.load(url: URLDefines.home, for: Home.self)
        self.home = home
        self.recommendVM.recommends = home.recommends
        self.dataChanged?()
      } catch {
        print("JSON Parsing Failed: \(error.localizedDescription)")
      }
    }
  }
}
