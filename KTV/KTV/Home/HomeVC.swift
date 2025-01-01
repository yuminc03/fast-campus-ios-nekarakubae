import UIKit

final class HomeVC: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
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
      UITableViewCell.self,
      forCellReuseIdentifier: "empty"
    )
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
    HomeSection.allCases.count
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
      return tableView.dequeueReusableCell(withIdentifier: HomeVideoCell.id, for: indexPath)
      
    case .recommend:
      let cell = tableView.dequeueReusableCell(
        withIdentifier: HomeRecommendContainerCell.id,
        for: indexPath
      )
      
      (cell as? HomeRecommendContainerCell)?.delegate = self
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
