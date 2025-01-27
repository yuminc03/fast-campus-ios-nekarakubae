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
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.isHidden = true
    
    collectionView.register(
      .init(nibName: HomeHeaderView.id, bundle: nil),
      forCellWithReuseIdentifier: HomeHeaderView.id
    )
    
    collectionView.register(
      .init(nibName: HomeRankingHeaderView.id, bundle: nil),
      forCellWithReuseIdentifier: HomeRankingHeaderView.id
    )
    
    collectionView.register(
      .init(nibName: HomeFooterView.id, bundle: nil),
      forCellWithReuseIdentifier: HomeFooterView.id
    )
    
    collectionView.register(
      .init(nibName: HomeVideoCell.id, bundle: .main),
      forCellWithReuseIdentifier: HomeVideoCell.id
    )
    
    collectionView.register(
      UINib(nibName: HomeRecommendContainerCell.id, bundle: .main),
      forCellWithReuseIdentifier: HomeRecommendContainerCell.id
    )
    
    collectionView.register(
      UINib(nibName: HomeRankingContainerCell.id, bundle: nil),
      forCellWithReuseIdentifier: HomeRankingContainerCell.id
    )
    
    collectionView.register(
      UINib(nibName: HomeRecentWatchContainerCell.id, bundle: .main),
      forCellWithReuseIdentifier: HomeRecentWatchContainerCell.id
    )
    
    collectionView.register(
      UICollectionViewCell.self,
      forCellWithReuseIdentifier: "empty"
    )
  }
  
  private func bind() {
    vm.dataChanged = { [weak self] in
      self?.collectionView.isHidden = false
      self?.collectionView.reloadData()
    }
  }
  
  private func insetForSection(_ section: HomeSection) -> UIEdgeInsets {
    switch section {
    case .header, .footer:
      return .zero
      
    case .video, .ranking, .recentWatch, .recommend:
      return .init(top: 0, left: 21, bottom: 21, right: 21)
    }
  }
}

// MARK: - UITableViewDelegate

extension HomeVC: UICollectionViewDelegateFlowLayout {
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    referenceSizeForHeaderInSection section: Int
  ) -> CGSize {
    guard let section = HomeSection(rawValue: section) else {
      return .zero
    }
    
    switch section {
    case .header:
      return .init(
        width: collectionView.frame.width,
        height: HomeHeaderView.height
      )
      
    case .video:
        return .zero
      
    case .ranking:
      return .init(
        width: collectionView.frame.width,
        height: HomeRankingHeaderView.height
      )
      
    case .recentWatch:
      return .zero
      
    case .recommend:
      return .zero
      
    case .footer:
      return .zero
    }
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    referenceSizeForFooterInSection section: Int
  ) -> CGSize {
    guard let section = HomeSection(rawValue: section) else {
      return .zero
    }
    
    switch section {
    case .header:
      return .zero
      
    case .video:
        return .zero
      
    case .ranking:
      return .zero
      
    case .recentWatch:
      return .zero
      
    case .recommend:
      return .zero
      
    case .footer:
      return .init(
        width: collectionView.frame.width,
        height: HomeFooterView.height
      )
    }
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    guard let section = HomeSection(rawValue: section) else {
      return .zero
    }
    
    return insetForSection(section)
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    guard let section = HomeSection(rawValue: section) else {
      return 0
    }
    
    switch section {
    case .header, .footer:
      return 0
      
    case .video, .ranking, .recentWatch, .recommend:
      return 21
    }
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    guard let section = HomeSection(rawValue: indexPath.section) else {
      return .zero
    }
    
    let inset = insetForSection(section)
    let width = collectionView.frame.width - inset.left - inset.right
    
    switch section {
    case .header, .footer:
      return .zero
      
    case .video:
      return .init(
        width: width,
        height: HomeVideoCell.height
      )
      
    case .ranking:
      return .init(
        width: width,
        height: HomeRankingContainerCell.height
      )
      
    case .recentWatch:
      return .init(
        width: width,
        height: HomeRecentWatchContainerCell.height
      )
      
    case .recommend:
      return .init(
        width: width,
        height: HomeRecommendContainerCell.height(vm: vm.recommendVM)
      )
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
      return 1
      
    case .recentWatch:
      return 1
      
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
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: HomeVideoCell.id,
        for: indexPath
      ) as? HomeVideoCell,
        let data = vm.home?.videos[indexPath.item]
      else {
        return collectionView.dequeueReusableCell(
          withReuseIdentifier: "empty",
          for: indexPath
        )
      }
      
      cell.setData(data)
      
      return cell
      
    case .ranking:
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: HomeRankingContainerCell.id,
        for: indexPath
      ) as? HomeRankingContainerCell,
        let data = vm.home?.rankings
      else {
        return collectionView.dequeueReusableCell(
          withReuseIdentifier: "empty",
          for: indexPath
        )
      }
      
      cell.setData(data)
      cell.delegate = self
      
      return cell
      
    case .recentWatch:
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: HomeRecentWatchContainerCell.id,
        for: indexPath
      ) as? HomeRecentWatchContainerCell,
        let data = vm.home?.recents
      else {
        return collectionView.dequeueReusableCell(
          withReuseIdentifier: "empty",
          for: indexPath
        )
      }
      
      cell.setData(data)
      cell.delegate = self
      
      return cell
      
    case .recommend:
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: HomeRecommendContainerCell.id,
        for: indexPath
      ) as? HomeRecommendContainerCell
      else {
        return collectionView.dequeueReusableCell(
          withReuseIdentifier: "empty",
          for: indexPath
        )
      }
      
      cell.setVM(vm.recommendVM)
      cell.delegate = self
      
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
    print("home recommend cell did select item at \(index)")
  }
  
  func homeRecommendContainerCellFoldChanged(cell: HomeRecommendContainerCell) {
    collectionView.collectionViewLayout.invalidateLayout()
  }
}

extension HomeVC: HomeRankingContainerCellDeleate {
  func homeRankingContainerCell(
    _ cell: HomeRankingContainerCell,
    didSelectItemAt index: Int
  ) {
    print("home ranking did select at: \(index)")
  }
}

extension HomeVC: HomeRecentWatchContainerCellDelegate {
  func homeRecentWatchContainerCell(
    _ cell: HomeRecentWatchContainerCell,
    didSelectItemAt index: Int
  ) {
    print("home recent watch did select at: \(index)")
  }
}
