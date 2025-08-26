import UIKit

final class HomeVC: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  private let vm = HomeVM()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    bind()
    
    vm.requestData()
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  private func setupUI() {
    collectionView.register(
      .init(nibName: HomeHeaderView.id, bundle: nil),
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: HomeHeaderView.id
    )
    
    collectionView.register(
      .init(nibName: HomeRankingHeaderView.id, bundle: nil),
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: HomeRankingHeaderView.id
    )
    
    collectionView.register(
      .init(nibName: HomeFooterView.id, bundle: nil),
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
      withReuseIdentifier: HomeFooterView.id
    )
    
    collectionView.register(
      .init(nibName: HomeVideoCell.id, bundle: .main),
      forCellWithReuseIdentifier: HomeVideoCell.id
    )
    
    collectionView.register(
      UINib(nibName: HomeRecommendContainerCell.id, bundle: .main),
      forCellWithReuseIdentifier: HomeRecommendContainerCell.id
    )
    
//    collectionView.register(
//      UINib(nibName: HomeRankingContainerCell.id, bundle: nil),
//      forCellWithReuseIdentifier: HomeRankingContainerCell.id
//    )
    
//    collectionView.register(
//      UINib(nibName: HomeRecentWatchContainerCell.id, bundle: .main),
//      forCellWithReuseIdentifier: HomeRecentWatchContainerCell.id
//    )
    
    collectionView.register(
      UINib(nibName: HomeRankingItemCell.id, bundle: nil),
      forCellWithReuseIdentifier: HomeRankingItemCell.id
    )
    
    collectionView.register(
      UINib(nibName: HomeRecentWatchItemCell.id, bundle: nil),
      forCellWithReuseIdentifier: HomeRecentWatchItemCell.id
    )
    
    collectionView.register(
      UICollectionViewCell.self,
      forCellWithReuseIdentifier: "empty"
    )
    
    collectionView.delegate = self
    collectionView.dataSource = self
    
    collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] section, _ in
      self?.makeSection(section)
    })
    collectionView.isHidden = true
  }
  
  private func bind() {
    vm.dataChanged = { [weak self] in
      self?.collectionView.isHidden = false
      self?.collectionView.reloadData()
    }
  }
  
  private func makeSection(_ section: Int) -> NSCollectionLayoutSection? {
    guard let section = HomeSection(rawValue: section) else {
      return nil
    }
    
    let itemSpace: CGFloat = 21
    let inset = NSDirectionalEdgeInsets(top: 0, leading: 21, bottom: 21, trailing: 21)
    
    switch section {
    case .header:
      return makeHeaderSection()
      
    case .video:
      return makeVideoSection(itemSpace, inset)
      
    case .ranking:
      return makeRankingSection(itemSpace, inset)
      
    case .recentWatch:
      return makeRecentWatchSection(itemSpace, inset)
      
    case .recommend:
      return makeRecommendSection(inset)
      
    case .footer:
      return makeFooterSection()
    }
  }
  
  private func makeHeaderSection() -> NSCollectionLayoutSection {
    let layoutSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .absolute(HomeHeaderView.height)
    )
    
    let group = NSCollectionLayoutGroup.vertical(
      layoutSize: layoutSize,
      subitems: [
        .init(layoutSize: .init(
          widthDimension: .absolute(0.1),
          heightDimension: .absolute(0.1)
        ))
      ]
    )
    
    let section = NSCollectionLayoutSection(group: group)
    section.boundarySupplementaryItems = [
      NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: layoutSize,
        elementKind: UICollectionView.elementKindSectionHeader,
        alignment: .top
      )
    ]
    
    return section
  }
  
  private func makeVideoSection(
    _ itemSpace: CGFloat,
    _ inset: NSDirectionalEdgeInsets
  ) -> NSCollectionLayoutSection? {
    let layoutSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .absolute(HomeVideoCell.height)
    )
    
    let item = NSCollectionLayoutItem(layoutSize: layoutSize)
    // item이 아주 많아져도 item에 맞춰서 VideoSection의 layout이 맞춰짐
    let group = NSCollectionLayoutGroup.vertical(layoutSize: layoutSize, subitems: [item])
    let section = NSCollectionLayoutSection(group: group)
    
    section.contentInsets = inset
    section.interGroupSpacing = itemSpace
    
    return section
  }
  
  private func makeRankingSection(
    _ itemSpace: CGFloat,
    _ inset: NSDirectionalEdgeInsets
  ) -> NSCollectionLayoutSection? {
    let headerLayoutSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .absolute(HomeRankingHeaderView.height)
    )
    
    let cellSize = HomeRankingItemCell.size
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .absolute(cellSize.width),
      heightDimension: .absolute(cellSize.height)
    )
    
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: .init(
        widthDimension: .absolute(cellSize.width),
        heightDimension: .absolute(265)),
      subitems: [item]
    )
    
    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = itemSpace
    section.contentInsets = inset
    section.orthogonalScrollingBehavior = .continuous
    section.boundarySupplementaryItems = [
      NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: headerLayoutSize,
        elementKind: UICollectionView.elementKindSectionHeader,
        alignment: .top
      )
    ]
    
    return section
  }
  
  private func makeRecentWatchSection(
    _ itemSpace: CGFloat,
    _ inset: NSDirectionalEdgeInsets
  ) -> NSCollectionLayoutSection? {
    let cellSize = HomeRecentWatchItemCell.itemSize
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .absolute(cellSize.width),
      heightDimension: .absolute(cellSize.height)
    )
    
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: .init(
        widthDimension: .absolute(cellSize.width),
        heightDimension: .absolute(189)
      ),
      subitems: [item]
    )
    
    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = itemSpace
    section.contentInsets = inset
    section.orthogonalScrollingBehavior = .continuous
    
    return section
  }
  
  private func makeRecommendSection(
    _ inset: NSDirectionalEdgeInsets
  ) -> NSCollectionLayoutSection? {
    let layoutSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .absolute(
        HomeRecommendContainerCell.height(vm: vm.recommendVM)
      )
    )
    
    let item = NSCollectionLayoutItem(layoutSize: layoutSize)
    let group = NSCollectionLayoutGroup.vertical(
      layoutSize: layoutSize,
      subitems: [item]
    )
    
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = inset
    
    return section
  }
  
  private func makeFooterSection() -> NSCollectionLayoutSection? {
    let layoutSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .absolute(HomeFooterView.height)
    )
    
    let group = NSCollectionLayoutGroup.vertical(
      layoutSize: layoutSize,
      subitems: [.init(layoutSize: .init(
        widthDimension: .absolute(0.1),
        heightDimension: .absolute(0.1)
      ))]
    )
    
    let section = NSCollectionLayoutSection(group: group)
    section.boundarySupplementaryItems = [
      NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: layoutSize,
        elementKind: UICollectionView.elementKindSectionFooter,
        alignment: .bottom
      )
    ]
    
    return section
  }
  
  private func insetForSection(_ section: HomeSection) -> UIEdgeInsets {
    switch section {
    case .header, .footer:
      return .zero
      
    case .video, .ranking, .recentWatch, .recommend:
      return .init(top: 0, left: 21, bottom: 21, right: 21)
    }
  }
  
  private func presentVideoVC() {
    let vc = VideoVC()
    present(vc, animated: true)
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeVC: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    guard let section = HomeSection(
      rawValue: indexPath.section
    ) else {
      return
    }
    
    switch section {
    case .header, .recommend, .footer:
      return
      
    case .video, .ranking, .recentWatch:
      presentVideoVC()
    }
  }
}

// MARK: - UITableViewDataSource

extension HomeVC: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return HomeSection.allCases.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let section = HomeSection(rawValue: section) else { return 0 }
    
    switch section {
    case .header:
      return 0
      
    case .video:
      return vm.home?.videos.count ?? 0
      
    case .ranking:
      return vm.home?.rankings.count ?? 0
      
    case .recentWatch:
      return vm.home?.recents.count ?? 0
      
    case .recommend:
      return 1
      
    case .footer:
      return 0
    }
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    viewForSupplementaryElementOfKind kind: String,
    at indexPath: IndexPath
  ) -> UICollectionReusableView {
    guard let section = HomeSection(rawValue: indexPath.section) else {
      return .init()
    }
    
    switch section {
    case .header:
      return collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: HomeHeaderView.id,
        for: indexPath
      )
      
    case .video:
      return .init()
      
    case .ranking:
      return collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: HomeRankingHeaderView.id,
        for: indexPath
      )
      
    case .recentWatch:
      return .init()
      
    case .recommend:
      return .init()
      
    case .footer:
      return collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: HomeFooterView.id,
        for: indexPath
      )
    }
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let section = HomeSection(rawValue: indexPath.section) else {
      return collectionView.dequeueReusableCell(
        withReuseIdentifier: "empty",
        for: indexPath
      )
    }
    
    switch section {
    case .header, .footer:
      return collectionView.dequeueReusableCell(
        withReuseIdentifier: "empty",
        for: indexPath
      )
      
    case .video:
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: HomeVideoCell.id,
        for: indexPath
      )
      
      if let cell = cell as? HomeVideoCell, let data = vm.home?.videos[indexPath.item] {
        cell.setData(data)
      }
      
      return cell
      
    case .ranking:
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: HomeRankingItemCell.id,
        for: indexPath
      )
      
      if let cell = cell as? HomeRankingItemCell,
         let data = vm.home?.rankings[indexPath.item]
      {
        cell.setData(data, rank: indexPath.item + 1)
      }
      
      return cell
      
    case .recentWatch:
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: HomeRecentWatchContainerCell.id,
        for: indexPath
      )
      
      if let cell = cell as? HomeRecentWatchContainerCell, let data = vm.home?.recents {
        cell.delegate = self
        cell.setData(data)
      }
      
      return cell
      
    case .recommend:
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: HomeRecommendContainerCell.id,
        for: indexPath
      )
      
      if let cell = cell as? HomeRecommendContainerCell {
        cell.delegate = self
        cell.setVM(vm.recommendVM)
      }
      
      return cell
    }
  }
}

// MARK: - HomeRecommendContainerCellDelegate

extension HomeVC: HomeRecommendContainerCellDelegate {
  func homeRecommendContainerCell(
    cell: HomeRecommendContainerCell,
    didSelectItemAt index: Int
  ) {
    presentVideoVC()
  }
  
  func homeRecommendContainerCellFoldChanged(cell: HomeRecommendContainerCell) {
    collectionView.collectionViewLayout.invalidateLayout()
  }
}

// MARK: - HomeRankingContainerCellDeleate

extension HomeVC: HomeRankingContainerCellDeleate {
  func homeRankingContainerCell(
    _ cell: HomeRankingContainerCell,
    didSelectItemAt index: Int
  ) {
    presentVideoVC()
  }
}

// MARK: - HomeRecentWatchContainerCellDelegate

extension HomeVC: HomeRecentWatchContainerCellDelegate {
  func homeRecentWatchContainerCell(
    _ cell: HomeRecentWatchContainerCell,
    didSelectItemAt index: Int
  ) {
    presentVideoVC()
  }
}
