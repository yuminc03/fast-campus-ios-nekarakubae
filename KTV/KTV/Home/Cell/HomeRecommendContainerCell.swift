import UIKit

protocol HomeRecommendContainerCellDelegate: AnyObject {
  func homeRecommendContainerCell(
    cell: HomeRecommendContainerCell,
    didSelectItemAt index: Int
  )
  
  func homeRecommendContainerCellFoldChanged(cell: HomeRecommendContainerCell)
}

final class HomeRecommendContainerCell: UICollectionViewCell {
  static let id = "HomeRecommendContainerCell"
  
  static func height(vm: HomeRecommendVM) -> CGFloat {
    let top: CGFloat = 84 - 6 // 첫번째 cell에서 bottom까지의 거리 - cell의 상단 여백
    let bottom: CGFloat = 68 - 6 // 마지막 cell첫번째 bottom까지의 거리 - cell의 하단 여백
    return VideoListItemCell.height * CGFloat(vm.itemCount) + top + bottom
  }
  
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var foldButton: UIButton!
  
  private var vm: HomeRecommendVM?
  
  weak var delegate: HomeRecommendContainerCellDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupUI()
  }
  
  @IBAction func didTapFoldButton(_ sender: Any) {
    vm?.toggleFoldState()
    delegate?.homeRecommendContainerCellFoldChanged(cell: self)
  }
  
  func setVM(_ vm: HomeRecommendVM) {
    self.vm = vm
    setButtonImage(vm.isFolded)
    tableView.reloadData()
    vm.foldChanged = { [weak self] in
      self?.tableView.reloadData()
      self?.setButtonImage($0)
    }
  }
  
  private func setButtonImage(_ isFolded: Bool) {
    let imageName = isFolded ? ImageResource.unfold : ImageResource.fold
    foldButton.setImage(UIImage(resource: imageName), for: .normal)
  }
  
  private func setupUI() {
    containerView.layer.cornerRadius = 10
    containerView.layer.borderWidth = 1
    containerView.layer.borderColor = UIColor(resource: .strokeLight).cgColor
    
    tableView.rowHeight = VideoListItemCell.height
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(
      UINib(nibName: VideoListItemCell.id, bundle: .main),
      forCellReuseIdentifier: VideoListItemCell.id
    )
  }
}

extension HomeRecommendContainerCell: UITableViewDelegate {
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return vm?.itemCount ?? 0
  }
}

extension HomeRecommendContainerCell: UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: VideoListItemCell.id,
      for: indexPath
    ) as? VideoListItemCell else {
      return UITableViewCell()
    }
    
    if let data = vm?.recommends?[indexPath.row] {
      cell.setData(data, rank: indexPath.row + 1)
    }
    
    return cell
  }
  
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    delegate?.homeRecommendContainerCell(cell: self, didSelectItemAt: indexPath.row)
  }
}
