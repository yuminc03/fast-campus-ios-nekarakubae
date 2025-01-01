import UIKit

final class TabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // 휴대폰 방향 세로로 고정
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .portrait
  }
}
