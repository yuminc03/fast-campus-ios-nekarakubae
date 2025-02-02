import UIKit

final class MoreTableViewCell: UITableViewCell {
  static let id = "MoreTableViewCell"
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var separatorView: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupUI()
  }
  
  func setItem(
    _ item: MoreItem,
    separatorHidden: Bool
  ) {
    titleLabel.text = item.title
    descriptionLabel.text = item.rightText
    separatorView.isHidden = separatorHidden
  }
  
  private func setupUI() {
    titleLabel.text = nil
    descriptionLabel.text = nil
  }
}
