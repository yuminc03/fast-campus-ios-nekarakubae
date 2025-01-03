import UIKit

final class HomeRankingItemCell: UICollectionViewCell {
  static let id = "HomeRankingItemCell"
    
  @IBOutlet weak var numberLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    layer.cornerRadius = 10
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    numberLabel.text = nil
  }
  
  func setRank(_ rank: Int) {
    numberLabel.text = "\(rank)"
  }
}
