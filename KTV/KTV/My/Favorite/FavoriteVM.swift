import Foundation

@MainActor
final class FavoriteVM {
  private(set) var favorite: Favorite?
  var dataChanged: (() -> Void)?
  
  func request() {
    Task {
      do {
        let favorite = try await DataLoader.load(
          url: URLDefines.favorite,
          for: Favorite.self
        )
        
        self.favorite = favorite
        self.dataChanged?()
      } catch {
        print("favorite load failed \(error.localizedDescription)")
      }
    }
  }
}
