import UIKit

final class VideoListItemCell: UITableViewCell {
  static let height: CGFloat = 71
  static let id = "VideoListItemCell"
  
  @IBOutlet weak var contentLeadingConstraint: NSLayoutConstraint!
  @IBOutlet weak var thumbnailContainerView: UIView!
  @IBOutlet weak var thumbnailImageView: UIImageView!
  @IBOutlet weak var playTimeBGView: UIView!
  @IBOutlet weak var playTimeLabel: UILabel!
  @IBOutlet weak var rankLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  private var imageTask: Task<Void, Never>?
  private static let timeformatter: DateComponentsFormatter = {
    let formatter = DateComponentsFormatter()
    
    formatter.unitsStyle = .positional
    formatter.zeroFormattingBehavior = .pad
    formatter.allowedUnits = [.minute, .second]
    return formatter
  }()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupUI()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    titleLabel.text = nil
    descriptionLabel.text = nil
    thumbnailImageView.image = nil
    playTimeLabel.text = nil
    rankLabel.text = nil
  }
  
  func setData(_ data: VideoListItem, rank: Int?) {
    rankLabel.isHidden = rank == nil
    if let rank {
      rankLabel.text = "\(rank)"
    }
    
    titleLabel.text = data.title
    descriptionLabel.text = data.channel
    playTimeLabel.text = Self.timeformatter.string(from: data.playtime)
    imageTask = thumbnailImageView.loadImage(url: data.imageUrl)
  }
  
  func setLeading(_ leading: CGFloat) {
      contentLeadingConstraint.constant = leading
  }
  
  private func setupUI() {
    backgroundConfiguration = .clear()
    
    thumbnailContainerView.layer.cornerRadius = 5
    rankLabel.layer.cornerRadius = 5
    rankLabel.clipsToBounds = true
    playTimeBGView.layer.cornerRadius = 3
  }
}
