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
      .init(nibName: HomeVideoCell.id, bundle: nil),
      forCellReuseIdentifier: HomeVideoCell.id
    )
  }
}

extension HomeVC: UITableViewDelegate {
  
}

extension HomeVC: UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    guard let section = HomeSection(rawValue: section) else { return 0 }
    
    switch section {
    case .video:
      return 2
    }
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard let section = HomeSection(rawValue: indexPath.section) else {
      return UITableViewCell()
    }
    
    switch section {
    case .video:
      return tableView.dequeueReusableCell(withIdentifier: HomeVideoCell.id, for: indexPath)
    }
  }
}
