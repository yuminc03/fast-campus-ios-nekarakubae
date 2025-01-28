import UIKit

final class BookmarkCell: UITableViewCell {
  static let id = "BookmarkCell"
  
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var thumbnailImageView: UIImageView!
  
  private var imageTask: Task<Void, Never>?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupUI()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    label.text = nil
    imageTask?.cancel()
    imageTask = nil
    thumbnailImageView.image = nil
  }
  
  func setData(_ data: Bookmark.Item) {
    label.text = data.channel
    imageTask = thumbnailImageView.loadImage(url: data.thumbnail)
  }
  
  private func setupUI() {
    thumbnailImageView.layer.cornerRadius = 10
  }
}
