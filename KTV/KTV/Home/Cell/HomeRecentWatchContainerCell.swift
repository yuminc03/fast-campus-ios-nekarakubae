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
  
  private var recents: [Home.Recent]?
  
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
  
  func setData(_ data: [Home.Recent]) {
    recents = data
    collectionView.reloadData()
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
    return recents?.count ?? 0
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: HomeRecentWatchItemCell.id,
      for: indexPath
    )
    
    if let cell = cell as? HomeRecentWatchItemCell,
       let data = recents?[indexPath.item]
    {
      cell.setData(data)
    }
    
    return cell
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    delegate?.homeRecentWatchContainerCell(self, didSelectItemAt: indexPath.item)
  }
}
