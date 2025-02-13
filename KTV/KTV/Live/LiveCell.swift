import UIKit

final class LiveCell: UICollectionViewCell {
  static let height: CGFloat = 76
  static let id = "LiveCell"
  
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var descriptionLabel: UILabel!
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var liveLabel: UILabel!
  private var imageTask: Task<Void, Never>?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupUI()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    resetUI()
  }
  
  
  private func setupUI() {
    liveLabel.layer.cornerRadius = 5
    liveLabel.clipsToBounds = true
    imageView.layer.cornerRadius = 5
  }
  
  private func resetUI() {
    imageTask?.cancel()
    imageTask = nil
    titleLabel.text = nil
    descriptionLabel.text = nil
  }
}
