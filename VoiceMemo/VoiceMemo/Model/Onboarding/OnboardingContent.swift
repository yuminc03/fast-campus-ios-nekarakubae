import Foundation

struct OnboardingContent: Hashable {
  let imageFileName: String
  let title: String
  let subTitle: String
  
  init(imageFileName: String, title: String, subTitle: String) {
    self.imageFileName = imageFileName
    self.title = title
    self.subTitle = subTitle
  }
}
