import UIKit

final class VideoVC: UIViewController {
  @IBOutlet weak var playButton: UIButton!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var updateDateLabel: UILabel!
  @IBOutlet weak var playCountLabel: UILabel!
  @IBOutlet weak var favoriteButton: UIButton!
  @IBOutlet weak var channelThumnailImageView: UIImageView!
  @IBOutlet weak var channelNameLabel: UILabel!
  @IBOutlet weak var recommendTableView: UITableView!
  @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var portraitControlPannel: UIView!
  
  private var contentSizeObservation: NSKeyValueObservation?
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    
    self.modalPresentationStyle = .fullScreen
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    self.modalPresentationStyle = .fullScreen
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
  }
  
  private func setupUI() {
    channelThumnailImageView.layer.cornerRadius = 14
    
    recommendTableView.delegate = self
    recommendTableView.dataSource = self
    recommendTableView.rowHeight = VideoListItemCell.height
    recommendTableView.register(
      .init(nibName: VideoListItemCell.id, bundle: nil),
      forCellReuseIdentifier: VideoListItemCell.id
    )
    
    contentSizeObservation = recommendTableView.observe(\.contentSize) { [weak self] tableView, _ in
      self?.tableViewHeightConstraint.constant = tableView.contentSize.height
    }
  }
  
  @IBAction func didTapComment(_ sender: Any) {
  }
  
  @IBAction func didTapRewind(_ sender: Any) {
  }
  
  @IBAction func didTapPlay(_ sender: Any) {
  }
  
  @IBAction func didTapFastForward(_ sender: Any) {
  }
  
  @IBAction func didTapExpand(_ sender: Any) {
  }
  
  @IBAction func didTapMore(_ sender: Any) {
    let vc = MoreVC()
    present(vc, animated: false)
  }
  
  @IBAction func didTapClose(_ sender: Any) {
    dismiss(animated: true)
  }
  
  @IBAction func toggleControlPannel(_ sender: Any) {
  }
}

// MARK: - UITableViewDelegate

extension VideoVC: UITableViewDelegate {
  
}

// MARK: - UITableViewDataSource

extension VideoVC:  UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return 10
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: VideoListItemCell.id,
      for: indexPath
    )
    
    return cell
  }
}
