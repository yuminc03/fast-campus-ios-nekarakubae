import UIKit

final class HomeRecommendItemCell: UITableViewCell {
  static let height: CGFloat = 71
  static let id = "HomeRecommendItemCell"
  
  @IBOutlet weak var thumbnailContainerView: UIView!
  @IBOutlet weak var thumbnailImageView: UIImageView!
  @IBOutlet weak var playTimeBGView: UIView!
  @IBOutlet weak var playTimeLabel: UILabel!
  @IBOutlet weak var rankLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    thumbnailContainerView.layer.cornerRadius = 5
    rankLabel.layer.cornerRadius = 5
    rankLabel.clipsToBounds = true
    playTimeBGView.layer.cornerRadius = 3
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
}
