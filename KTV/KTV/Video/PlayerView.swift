import UIKit
import AVKit

protocol PlayerviewDelegate: AnyObject {
  func playerViewReadyToPlay(_ playerView: PlayerView)
  func playerView(_ playerView: PlayerView, didPlay playTime: Double, playableTime: Double)
  func playerViewDidFinishToPlay(_ playerView: PlayerView)
}

final class PlayerView: UIView {
  
  var avPlayerLayer: AVPlayerLayer? {
    return layer as? AVPlayerLayer
  }
  
  var player: AVPlayer? {
    get {
      return avPlayerLayer?.player
    }
    set {
      // 하나의 player만 set될 수 있음
      if let oldPlayer = avPlayerLayer?.player {
        unsetPlayer(player: oldPlayer)
      }
      
      avPlayerLayer?.player = newValue
      
      if let player = newValue {
        setup(player: player)
      }
    }
  }
  
  var isPlaying: Bool {
    guard let player else { return false }
    
    return player.rate != 0
  }
  
  var totalPlayTime: Double {
    return player?.currentItem?.duration.seconds ?? 0
  }
  
  weak var delegate: PlayerviewDelegate?
  
  private var playObservation: Any?
  private var statusObservation: NSKeyValueObservation?
  
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
  
  func play() {
    player?.play()
  }
  
  func pause() {
    player?.pause()
  }
  
  func seek(to percent: Double) {
    guard let currentItem = player?.currentItem?.currentTime().seconds else { return }
    
    player?.seek(to: .init(
      seconds: percent * totalPlayTime,
      preferredTimescale: 1
    ))
  }
  
  func forward(to seconds: Double = 10) {
    guard let currentTime = player?.currentItem?.currentTime().seconds else { return }
    
    player?.seek(to: .init(
      seconds: currentTime + seconds,
      preferredTimescale: 1
    ))
  }
  
  func rewind(to seconds: Double = 10) {
    guard let currentTime = player?.currentItem?.currentTime().seconds else { return }
    
    player?.seek(to: .init(
      seconds: currentTime - seconds,
      preferredTimescale: 1
    ))
  }
}

extension PlayerView {
  private func setup(player: AVPlayer) {
    playObservation = player.addPeriodicTimeObserver(
      forInterval: .init(seconds: 0.5, preferredTimescale: 10),
      queue: .main
    ) { [weak self, weak player] time in
      guard let self else { return }
      
      // 재생 가능한 time range 가져옴
      guard let currentItem = player?.currentItem,
            currentItem.status == .readyToPlay,
            let timeRanges = (currentItem.loadedTimeRanges as? [CMTimeRange])?.first
      else {
        return
      }
      
      let playableTime = timeRanges.start.seconds + timeRanges.duration.seconds
      let playTime = time.seconds
      delegate?.playerView(self, didPlay: playTime, playableTime: playableTime)
    }
    
    statusObservation = player.currentItem?.observe(\.status) { [weak self] item, _ in
      guard let self else { return }
      
      switch item.status {
      case .readyToPlay:
        delegate?.playerViewReadyToPlay(self)
        
      case .failed, .unknown:
        print("failed to play: \(item.error?.localizedDescription ?? "")")
        
      @unknown default:
        print("failed to play: \(item.error?.localizedDescription ?? "")")
      }
    }
  }
  
  private func unsetPlayer(player: AVPlayer) {
    statusObservation?.invalidate()
    statusObservation = nil
    if let playObservation {
      player.removeTimeObserver(playObservation)
    }
  }
  
  private func setupNotification() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(didPlayToEnd),
      name: AVPlayerItem.didPlayToEndTimeNotification,
      object: nil
    )
  }
  
  @objc
  private func didPlayToEnd(_ notification: Notification) {
    delegate?.playerViewDidFinishToPlay(self)
  }
}
