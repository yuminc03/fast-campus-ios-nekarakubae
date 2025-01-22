import Foundation

final class HomeRecommendVM {
  private(set) var isFolded = true {
    didSet {
      foldChanged?(isFolded)
    }
  }
  
  var foldChanged: ((Bool) -> Void)?
  var recommends: [Home.Recommend]?
  var itemCount: Int {
    let count = isFolded ? 5 : recommends?.count ?? 0
    return min(recommends?.count ?? 0, count)
  }
  
  func toggleFoldState() {
    isFolded.toggle()
  }
}
