import UIKit

final class FavoriteVC: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  private let vm = FavoriteVM()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
  }
  
  private func setupUI() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(
      UINib(nibName: "VideoListItemCell", bundle: nil),
      forCellReuseIdentifier: VideoListItemCell.id
    )
    
    vm.dataChanged = { [weak self] in
      self?.tableView.reloadData()
    }
    
    vm.request()
  }
}

extension FavoriteVC: UITableViewDelegate {
  func tableView(
    _ tableView: UITableView,
    heightForRowAt indexPath: IndexPath
  ) -> CGFloat {
    return VideoListItemCell.height
  }
}

extension FavoriteVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    vm.favorite?.list.count ?? 0
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoListItemCell.id, for: indexPath) as? VideoListItemCell,
          let data = self.vm.favorite?.list[indexPath.row] else {
      return UITableViewCell()
    }
    
    cell.setData(data, rank: nil)
    cell.setLeading(21)
    
    return cell
  }
}
