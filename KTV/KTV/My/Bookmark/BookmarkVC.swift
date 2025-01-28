import UIKit

final class BookmarkVC: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  private let vm = BookmarkVM()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
  }
  
  private func setupUI() {
    tableView.register(
      .init(nibName: BookmarkCell.id, bundle: nil),
      forCellReuseIdentifier: BookmarkCell.id
    )
    
    tableView.delegate = self
    tableView.dataSource = self
    
    vm.dataChanged = { [weak self] in
      self?.tableView.reloadData()
    }
    
    vm.request()
  }
}

extension BookmarkVC: UITableViewDelegate {
  
}

extension BookmarkVC: UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return vm.channels?.count ?? 0
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: BookmarkCell.id,
      for: indexPath
    ) as? BookmarkCell,
      let data = vm.channels?[indexPath.row]
    else {
      return UITableViewCell()
    }
    
    cell.setData(data)
    
    return cell
  }
}
