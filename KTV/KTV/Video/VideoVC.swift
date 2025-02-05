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
  @IBOutlet weak var playerView: PlayerView!
  
  private static let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.MMdd"
    
    return formatter
  }()
  
  private let vm = VideoVM()
  
  private var contentSizeObservation: NSKeyValueObservation?
  private var isControlPannelHidden: Bool = true {
    didSet {
      portraitControlPannel.isHidden = isControlPannelHidden
    }
  }
  
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
    bindVM()
    vm.request()
  }
  
  private func setupUI() {
    playerView.delegate = self

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
  
  private func bindVM() {
    vm.dataChangeHandler = { [weak self] in
      self?.setupData($0)
    }
  }
  
  private func setupData(_ video: Video) {
    titleLabel.text = video.title
    channelThumnailImageView.loadImage(url: video.channelImageUrl)
    channelNameLabel.text = video.channel
    updateDateLabel.text = Self.dateFormatter.string(from: Date(timeIntervalSince1970: video.uploadTimestamp))
    playCountLabel.text = "재생수 \(video.playCount)"
    favoriteButton.setTitle("\(video.favoriteCount)", for: .normal)
    
    playerView.set(url: video.videoURL)
    playerView.play()
    
    recommendTableView.reloadData()
  }
  
  @IBAction func didTapComment(_ sender: Any) {
  }
  
  @IBAction func didTapRewind(_ sender: Any) {
    playerView.rewind()
  }
  
  @IBAction func didTapPlay(_ sender: Any) {
    if playerView.isPlaying {
      playerView.pause()
    } else {
      playerView.play()
    }
    
    updatePlayButton(isPlaying: playerView.isPlaying)
  }
  
  @IBAction func didTapFastForward(_ sender: Any) {
    playerView.forward()
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
    isControlPannelHidden.toggle()
  }
  
  private func updatePlayButton(isPlaying: Bool) {
    playButton.setImage(
      isPlaying ? .smallPause : .smallPlay,
      for: .normal
    )
  }
}

// MARK: - PlayerViewDeleagte

extension VideoVC: PlayerviewDelegate {
  func playerViewReadyToPlay(_ playerView: PlayerView) {
    updatePlayButton(isPlaying: playerView.isPlaying)
  }
  
  func playerView(
    _ playerView: PlayerView,
    didPlay playTime: Double,
    playableTime: Double
  ) {
    
  }
  
  func playerViewDidFinishToPlay(_ playerView: PlayerView) {
    playerView.seek(to: 0)
    updatePlayButton(isPlaying: false)
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
    return vm.video?.recommends.count ?? 0
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: VideoListItemCell.id,
      for: indexPath
    ) as? VideoListItemCell
    else {
      return UITableViewCell()
    }
    
    if let data = vm.video?.recommends[indexPath.row] {
      cell.setData(data, rank: indexPath.row + 1)
    }
    
    return cell
  }
}
