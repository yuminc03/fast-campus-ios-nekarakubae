import UIKit

final class HomeVideoCell: UITableViewCell {
  
  static let id = "HomeVideoCell"
  static let height: CGFloat = 320
  
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var thumbnailImageView: UIImageView!
  @IBOutlet weak var hotImageView: UIImageView!
  @IBOutlet weak var channelImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subTitleLabel: UILabel!
  @IBOutlet weak var channelTitleLabel: UILabel!
  @IBOutlet weak var channelSubTitleLabel: UILabel!
  
  private var thumbnailTask: Task<Void, Never>?
  private var channelThumbnailTask: Task<Void, Never>?
  
  // XIB 파일이 인스턴스로 만들어지고 UI와 이 class가 서로 link되었을 때 호출
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupUI()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    thumbnailTask?.cancel()
    thumbnailTask = nil
    channelThumbnailTask?.cancel()
    channelThumbnailTask = nil
    
    thumbnailImageView.image = nil
    titleLabel.text = nil
    subTitleLabel.text = nil
    channelTitleLabel.text = nil
    channelImageView.image = nil
    channelSubTitleLabel.text = nil
  }
  
  func setData(_ data: Home.Video) {
    titleLabel.text = data.title
    subTitleLabel.text = data.subtitle
    channelTitleLabel.text = data.channel
    channelSubTitleLabel.text = data.channelDescription
    hotImageView.isHidden = data.isHot == false
    thumbnailTask = thumbnailImageView.loadImage(url: data.imageURL)
    channelThumbnailTask = channelImageView.loadImage(url: data.channelThumbnailURL)
  }
  
  private func setupUI() {
    containerView.layer.cornerRadius = 10
    containerView.layer.borderColor = UIColor(resource: .strokeLight).cgColor
    containerView.layer.borderWidth = 1
  }
}
