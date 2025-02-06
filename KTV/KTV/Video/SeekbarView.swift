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
  
  private func setupUI() {
    
  }
}
