import UIKit

final class HomeVideoCell: UITableViewCell {
  
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var thumbnailImageView: UIImageView!
  @IBOutlet weak var hotImageView: UIImageView!
  @IBOutlet weak var channelImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subTitleLabel: UILabel!
  @IBOutlet weak var channelTitleLabel: UIView!
  @IBOutlet weak var channelSubTitleLabel: UILabel!
  
  // XIB 파일이 인스턴스로 만들어지고 UI와 이 class가 서로 link되었을 때 호출
  override func awakeFromNib() {
    super.awakeFromNib()
    
    containerView.layer.cornerRadius = 10
    containerView.layer.borderColor = UIColor(resource: .strokeLight).cgColor
    containerView.layer.borderWidth = 1
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
