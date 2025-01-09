import UIKit

protocol HomeRankingContainerCellDeleate: AnyObject {
  func homeRankingContainerCell(
    _ cell: HomeRankingContainerCell,
    didSelectItemAt index: Int
  )
}

final class HomeRankingContainerCell: UITableViewCell {
  
  static let id = "HomeRankingContainerCell"
  static let height: CGFloat = 349
  @IBOutlet weak var collectionView: UICollectionView!
  
  private var rankings: [Home.Ranking]?
  
  weak var delegate: HomeRankingContainerCellDeleate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    collectionView.register(
      UINib(nibName: HomeRankingItemCell.id, bundle: nil),
      forCellWithReuseIdentifier: HomeRankingItemCell.id
    )
    
    collectionView.delegate = self
    collectionView.dataSource = self
  }
  
  func setData(_ data: [Home.Ranking]) {
    rankings = data
    collectionView.reloadData()
  }
}

extension HomeRankingContainerCell: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    delegate?.homeRankingContainerCell(self, didSelectItemAt: indexPath.item)
  }
}

extension HomeRankingContainerCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return rankings?.count ?? 0
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeRankingItemCell.id, for: indexPath)
    
    if let cell = cell as? HomeRankingItemCell,
       let data = rankings?[indexPath.item]
    {
      cell.setData(data, rank: indexPath.item + 1)
    }
    
    return cell
  }
}
