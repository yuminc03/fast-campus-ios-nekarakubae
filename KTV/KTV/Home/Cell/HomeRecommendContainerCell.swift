import UIKit

protocol HomeRecommendContainerCellDelegate: AnyObject {
  func homeRecommendContainerCell(
    cell: HomeRecommendContainerCell,
    didSelectItemAt index: Int
  )
}

final class HomeRecommendContainerCell: UITableViewCell {
  static let id = "HomeRecommendContainerCell"
  
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var foldButton: UIButton!
  
  private var recommends: [Home.Recommend]?
  
  weak var delegate: HomeRecommendContainerCellDelegate?
  static var height: CGFloat {
    let top: CGFloat = 84 - 6 // 첫번째 cell에서 bottom까지의 거리 - cell의 상단 여백
    let bottom: CGFloat = 68 - 6 // 마지막 cell첫번째 bottom까지의 거리 - cell의 하단 여백
    let footerInset: CGFloat = 51 // container -> footer 까지의 여백
    return HomeRecommendItemCell.height * 5 + top + bottom + footerInset
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupUI()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func setData(_ data: [Home.Recommend]) {
    recommends = data
    tableView.reloadData()
  }
  
  @IBAction func didTapFoldButton(_ sender: Any) {
    
  }
  
  private func setupUI() {
    containerView.layer.cornerRadius = 10
    containerView.layer.borderWidth = 1
    containerView.layer.borderColor = UIColor(resource: .strokeLight).cgColor
    
    tableView.rowHeight = HomeRecommendItemCell.height
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(
      UINib(nibName: HomeRecommendItemCell.id, bundle: .main),
      forCellReuseIdentifier: HomeRecommendItemCell.id
    )
  }
}

extension HomeRecommendContainerCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}

extension HomeRecommendContainerCell: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: HomeRecommendItemCell.id,
      for: indexPath
    ) as? HomeRecommendItemCell else {
      return UITableViewCell()
    }
    
    if let data = recommends?[indexPath.row] {
      cell.setData(data, rank: indexPath.row + 1)
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate?.homeRecommendContainerCell(cell: self, didSelectItemAt: indexPath.row)
  }
}
