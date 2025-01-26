import UIKit

protocol HomeRankingContainerCellDeleate: AnyObject {
  func homeRankingContainerCell(
    _ cell: HomeRankingContainerCell,
    didSelectItemAt index: Int
  )
}

final class HomeRankingContainerCell: UICollectionViewCell {
  
  static let id = "HomeRankingContainerCell"
  static let height: CGFloat = 265
  @IBOutlet weak var collectionView: UICollectionView!
  
  private var rankings: [Home.Ranking]?
  
  weak var delegate: HomeRankingContainerCellDeleate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupUI()
  }
  
  func setData(_ data: [Home.Ranking]) {
    rankings = data
    collectionView.reloadData()
  }
  
  private func setupUI() {
    collectionView.register(
      UINib(nibName: HomeRankingItemCell.id, bundle: nil),
      forCellWithReuseIdentifier: HomeRankingItemCell.id
    )
    
    collectionView.delegate = self
    collectionView.dataSource = self
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
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeRankingItemCell.id, for: indexPath) as? HomeRankingItemCell,
          let data = rankings?[indexPath.item]
    else {
      return UICollectionViewCell()
    }
    
    cell.setData(data, rank: indexPath.item + 1)
    
    return cell
  }
}
