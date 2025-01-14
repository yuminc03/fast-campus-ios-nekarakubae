import UIKit

final class HomeVC: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  private let vm = HomeVM()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    bind()
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  private func setupUI() {
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.register(
      .init(nibName: HomeHeaderCell.id, bundle: nil),
      forCellReuseIdentifier: HomeHeaderCell.id
    )
    tableView.register(
      .init(nibName: HomeVideoCell.id, bundle: nil),
      forCellReuseIdentifier: HomeVideoCell.id
    )
    tableView.register(
      UINib(nibName: HomeRecommendContainerCell.id, bundle: .main),
      forCellReuseIdentifier: HomeRecommendContainerCell.id
    )
    tableView.register(
      UINib(nibName: HomeFooterCell.id, bundle: .main),
      forCellReuseIdentifier: HomeFooterCell.id
    )
    tableView.register(
      UINib(nibName: HomeRankingContainerCell.id, bundle: nil),
      forCellReuseIdentifier: HomeRankingContainerCell.id
    )
    tableView.register(
      UINib(nibName: HomeRecentWatchContainerCell.id, bundle: nil),
      forCellReuseIdentifier: HomeRecentWatchContainerCell.id
    )
    tableView.register(
      UITableViewCell.self,
      forCellReuseIdentifier: "empty"
    )
  }
  
  private func bind() {
    vm.dataChanged = { [weak self] in
      self?.tableView.isHidden = false
      self?.tableView.reloadData()
    }
    
    vm.requestData()
  }
}

// MARK: - UITableViewDelegate

extension HomeVC: UITableViewDelegate {
  func tableView(
    _ tableView: UITableView,
    heightForRowAt indexPath: IndexPath
  ) -> CGFloat {
      guard let section = HomeSection(rawValue: indexPath.section) else {
          return 0
      }
    
      switch section {
      case .header:
          return HomeHeaderCell.height
      case .video:
          return HomeVideoCell.height
      case .ranking:
        return HomeRankingContainerCell.height
      case .recentWatch:
        return HomeRecentWatchContainerCell.height
      case .recommend:
          return HomeRecommendContainerCell.height
      case .footer:
          return HomeFooterCell.height
      }
  }
}

// MARK: - UITableViewDataSource

extension HomeVC: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return HomeSection.allCases.count
  }
  
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    guard let section = HomeSection(rawValue: section) else { return 0 }
    
    switch section {
    case .header:
      return 1
    case .video:
      return 2
    case .ranking:
      return 1
    case .recentWatch:
      return 1
    case .recommend:
      return 1
    case .footer:
      return 1
    }
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard let section = HomeSection(rawValue: indexPath.section) else {
      return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath)
    }
    
    switch section {
    case .header:
      return tableView.dequeueReusableCell(
        withIdentifier: HomeHeaderCell.id,
        for: indexPath
      )
      
    case .video:
      guard let cell = tableView.dequeueReusableCell(
        withIdentifier: HomeVideoCell.id,
        for: indexPath
      ) as? HomeVideoCell else {
        return UITableViewCell()
      }
      
      if let data = vm.home?.videos[indexPath.row] {
        cell.setData(data)
      }
      
      return cell
      
    case .ranking:
      let cell = tableView.dequeueReusableCell(
        withIdentifier: HomeRankingContainerCell.id,
        for: indexPath
      )
      
      if let cell = cell as? HomeRankingContainerCell, let data = vm.home?.rankings {
        cell.setData(data)
        cell.delegate = self
      }
      
      return cell
      
    case .recentWatch:
      guard let cell = tableView.dequeueReusableCell(
        withIdentifier: HomeRecentWatchContainerCell.id,
        for: indexPath
      ) as? HomeRecentWatchContainerCell else {
        return UITableViewCell()
      }
      
      if let data = vm.home?.recents {
        cell.delegate = self
        cell.setData(data)
      }
      
      return cell
      
    case .recommend:
      guard let cell = tableView.dequeueReusableCell(
        withIdentifier: HomeRecommendContainerCell.id,
        for: indexPath
      ) as? HomeRecommendContainerCell else {
        return UITableViewCell()
      }
      
      if let data = vm.home?.recommends {
        cell.delegate = self
        cell.setData(data)
      }
      
      return cell
      
    case .footer:
      return tableView.dequeueReusableCell(
        withIdentifier: HomeFooterCell.id,
        for: indexPath
      )
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
