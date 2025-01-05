import UIKit

protocol HomeRecentWatchContainerCellDelegate: AnyObject {
    
    func homeRecentWatchContainerCell(
      _ cell: HomeRecentWatchContainerCell,
      didSelectItemAt index: Int
    )
}

final class HomeRecentWatchContainerCell: UITableViewCell {
  static let id = "HomeRecentWatchContainerCell"
  static let height: CGFloat = 209
  @IBOutlet weak var collectionView: UICollectionView!
  weak var delegate: HomeRecentWatchContainerCellDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    collectionView.layer.cornerRadius = 10
    collectionView.layer.borderWidth = 1
    collectionView.layer.borderColor = UIColor(resource: .strokeLight).cgColor
    collectionView.register(
      UINib(nibName: HomeRecentWatchItemCell.id, bundle: nil),
      forCellWithReuseIdentifier: HomeRecentWatchItemCell.id
    )
    
    collectionView.delegate = self
    collectionView.dataSource = self
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}

// MARK: - UICollectionViewDelegate

extension HomeRecentWatchContainerCell: UICollectionViewDelegate {
  
}

// MARK: - UICollectionViewDataSource

extension HomeRecentWatchContainerCell: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return 5
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeRecentWatchItemCell.id, for: indexPath)
    return cell
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    delegate?.homeRecentWatchContainerCell(self, didSelectItemAt: indexPath.item)
  }
}
