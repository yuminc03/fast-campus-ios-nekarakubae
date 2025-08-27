import UIKit

final class TabBarController: UITabBarController {
  
  weak var videoVC: VideoVC?
  
  // 휴대폰 방향 세로로 고정
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .portrait
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

// MARK: - VideoVCDelegate

extension TabBarController: VideoVCDelegate {
  func videoVC(
    _ vc: VideoVC,
    yPositionForMinizeView height: CGFloat
  ) -> CGFloat {
    // tabBar위에 배치
    return tabBar.frame.minY - height
  }
  
  func videoVCDidMinimize(_ vc: VideoVC) {
    videoVC = vc
    addChild(vc)
    view.addSubview(vc.view)
    vc.didMove(toParent: self)
  }
  
  func videoVCNeedsMaximize(_ vc: VideoVC) {
    videoVC = nil
    vc.willMove(toParent: nil)
    vc.view.removeFromSuperview()
    vc.removeFromParent()
    present(vc, animated: true)
  }
  
  func videoVCDidTapClose(_ vc: VideoVC) {
    vc.willMove(toParent: nil)
    vc.view.removeFromSuperview()
    vc.removeFromParent()
    videoVC = nil
  }
}

// MARK: - VideoVCContainerProtocol

extension TabBarController: VideoVCContainerProtocol {
  func presentCurrentVC() {
    guard let videoVC else { return }
    
    videoVC.willMove(toParent: nil)
    videoVC.view.removeFromSuperview()
    videoVC.removeFromParent()
    present(videoVC, animated: true)
    self.videoVC = nil
  }
}
