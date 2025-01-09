import UIKit

final class HomeRecentWatchItemCell: UICollectionViewCell {
  static let id = "HomeRecentWatchItemCell"
  
  @IBOutlet weak var thumbnailImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  
  private var imageTask: Task<Void, Never>?
  private static let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYMMDD."
    
    return formatter
  }()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupUI()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    imageTask?.cancel()
    imageTask = nil
    thumbnailImageView.image = nil
    titleLabel.text = nil
    subtitleLabel.text = nil
    dateLabel.text = nil
  }
  
  func setData(_ data: Home.Recent) {
    titleLabel.text = data.title
    subtitleLabel.text = data.channel
    dateLabel.text = Self.dateFormatter.string(from: .init(timeIntervalSince1970: data.timeStamp))
    
    imageTask = thumbnailImageView.loadImage(url: data.imageURL)
  }
  
  private func setupUI() {
    thumbnailImageView.layer.cornerRadius = 42
    thumbnailImageView.layer.borderWidth = 2
    thumbnailImageView.layer.borderColor = UIColor(resource: .strokeLight).cgColor
  }
}
