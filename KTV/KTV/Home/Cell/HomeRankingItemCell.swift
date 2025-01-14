import UIKit

final class HomeRankingItemCell: UICollectionViewCell {
  static let id = "HomeRankingItemCell"
    
  @IBOutlet weak var thumbnailImageView: UIImageView!
  @IBOutlet weak var numberLabel: UILabel!
  
  private var imageTask: Task<Void, Never>?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupUI()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    numberLabel.text = nil
    thumbnailImageView.image = nil
    imageTask?.cancel()
    imageTask = nil
  }
  
  func setData(_ data: Home.Ranking, rank: Int) {
    numberLabel.text = "\(rank)"
    imageTask = thumbnailImageView.loadImage(url: data.imageURL)
  }
  
  private func setupUI() {
    layer.cornerRadius = 10
  }
}
