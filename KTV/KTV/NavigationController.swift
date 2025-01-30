import UIKit

final class NavigationController: UINavigationController {
  
  override var childForStatusBarStyle: UIViewController? {
    return topViewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
