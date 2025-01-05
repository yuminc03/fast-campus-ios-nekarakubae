import UIKit

final class HomeRecentWatchItemCell: UICollectionViewCell {
  static let id = "HomeRecentWatchItemCell"
  
  @IBOutlet weak var thumbnailImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupUI()
  }
  
  private func setupUI() {
    thumbnailImageView.layer.cornerRadius = 42
    thumbnailImageView.layer.borderWidth = 2
    thumbnailImageView.layer.borderColor = UIColor(resource: .strokeLight).cgColor
  }
}
