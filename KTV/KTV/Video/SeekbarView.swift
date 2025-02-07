import UIKit

protocol SeekBarViewDelegate: AnyObject {
  func seekbar(
    _ seekbar: SeekbarView,
    seekToPercent percent: Double
  )
}

final class SeekbarView: UIView {
  @IBOutlet weak var totalPlayTimeView: UIView!
  @IBOutlet weak var playablePlayTimeView: UIView!
  @IBOutlet weak var currentPlayTimeView: UIView!
  @IBOutlet weak var playableTimeWidth: NSLayoutConstraint!
  @IBOutlet weak var playTimeWidth: NSLayoutConstraint!
  
  private(set) var totalPlayTime: Double = 0
  private(set) var playableTime: Double = 0
  private(set) var currentPlayTime: Double = 0
  
  weak var delegate: SeekBarViewDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupUI()
  }
  
  func setTotalPlayTime(_ totalPlayTime: Double) {
    self.totalPlayTime = totalPlayTime
    update()
  }
  
  func setPlayTime(_ playTime: Double, playableTime: Double) {
    currentPlayTime = playTime
    self.playableTime = playableTime
    update()
  }
  
  private func update() {
    guard totalPlayTime > 0 else { return }
    
    playableTimeWidth.constant = widthForTime(playableTime)
    playTimeWidth.constant = widthForTime(currentPlayTime)
    
    UIView.animate(withDuration: 0.2) { [weak self] in
      // layout을 다음 cycle을 기다리지 않고 바로 처리함
      self?.layoutIfNeeded()
    }
  }
  
  private func widthForTime(_ time: Double) -> CGFloat {
    return min(frame.width, frame.width * time / totalPlayTime)
  }
  
  private func setupUI() {
    totalPlayTimeView.layer.cornerRadius = 1
    playablePlayTimeView.layer.cornerRadius
     = 1
    currentPlayTimeView.layer.cornerRadius = 1
  }
}
