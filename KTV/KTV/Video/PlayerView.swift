import UIKit
import AVKit

final class PlayerView: UIView {
  
  var avPlayerLayer: AVPlayerLayer? {
    return layer as? AVPlayerLayer
  }
  
  var player: AVPlayer? {
    get {
      return avPlayerLayer?.player
    }
    set {
      avPlayerLayer?.player = newValue
    }
  }
  
  var isPlaying: Bool {
    guard let player else { return false }
    
    return player.rate != 0
  }
  
  var totalPlayTime: Double {
    return player?.currentItem?.duration.seconds ?? 0
  }
  
  override class var layerClass: AnyClass {
    return AVPlayerLayer.self
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  func set(url: URL) {
    player = .init(playerItem: .init(
      asset: AVURLAsset(url: url)
    ))
  }
}
