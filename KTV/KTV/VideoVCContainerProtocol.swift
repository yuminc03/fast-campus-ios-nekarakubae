import Foundation

protocol VideoVCContainerProtocol {
  var videoVC: VideoVC? { get }
  func presentCurrentVC()
}
