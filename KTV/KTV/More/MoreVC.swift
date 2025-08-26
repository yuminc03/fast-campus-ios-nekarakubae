import UIKit

final class MoreVC: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var headerView: UIView!
  
  private let vm = MoreVM()
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    
    self.modalPresentationStyle = .overFullScreen
    self.modalTransitionStyle = .crossDissolve
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    self.modalPresentationStyle = .overFullScreen
    self.modalTransitionStyle = .crossDissolve
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    setupCornerRadius()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    setupCornerRadius()
  }
  
  override func viewWillTransition(
    to size: CGSize,
    with coordinator: any UIViewControllerTransitionCoordinator
  ) {
    coordinator.animate { _ in
      self.setupCornerRadius()
    }
    
    super.viewWillTransition(to: size, with: coordinator)
  }
  
  private func setupUI() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = 48
    tableView.register(
      .init(nibName: MoreTableViewCell.id, bundle: nil),
      forCellReuseIdentifier: MoreTableViewCell.id
    )
    
    setupCornerRadius()
  }
  
  private func setupCornerRadius() {
    let path = UIBezierPath(
      roundedRect: headerView.bounds,
      byRoundingCorners: [.topLeft, .topRight],
      cornerRadii: CGSize(width: 13, height: 13)
    )
    
    let maskLayer = CAShapeLayer()
    maskLayer.path = path.cgPath
    headerView.layer.mask = maskLayer
    
//    headerView.layer.cornerRadius = 13
//    headerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
  }
  
  @IBAction func didTapClose(_ sender: Any) {
    dismiss(animated: true)
  }
}

// MARK: - UITableViewDelegate

extension MoreVC: UITableViewDelegate {
  
}

// MARK: - UITableViewDataSource

extension MoreVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return vm.items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: MoreTableViewCell.id,
      for: indexPath
    ) as? MoreTableViewCell else {
      return UITableViewCell()
    }
    
    cell.setItem(
      vm.items[indexPath.row],
      separatorHidden: indexPath.row + 1 == vm.items.count
    )
    
    return cell
  }
}
