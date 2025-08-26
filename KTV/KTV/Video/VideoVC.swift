import UIKit
import AVKit

final class VideoVC: UIViewController {
  private let chattingLandscapeConstraint: CGFloat = -500
  
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
  
  @IBOutlet var landscapeControlPannel: UIView!
  @IBOutlet var landscapePlayButton: UIButton!
  @IBOutlet var landscapeTitleLabel: UILabel!
  @IBOutlet var landscapePlayTimeLabel: UILabel!
  
  @IBOutlet var seekbar: SeekbarView!
  
  @IBOutlet weak var playerView: PlayerView!
  @IBOutlet var playerViewBottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var chattingViewBottomConstraint: NSLayoutConstraint!
  
  @IBOutlet var chattingView: ChattingView!
  
  @IBOutlet weak var minimizePlayerView: PlayerView!
  @IBOutlet weak var minimizeView: UIView!
  @IBOutlet weak var minimizeViewBottomConstraint: NSLayoutConstraint!
  
  var isLiveMode = false
  
  private var pipController: AVPictureInPictureController?
  
  private static let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.MMdd"
    
    return formatter
  }()
  
  private let vm = VideoVM()
  
  private var contentSizeObservation: NSKeyValueObservation?
  private var isControlPannelHidden: Bool = true {
    didSet {
      if isLandscape(size: view.frame.size) {
        landscapeControlPannel.isHidden = isControlPannelHidden
      } else {
        portraitControlPannel.isHidden = isControlPannelHidden
      }
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
    chattingView.isHidden = isLiveMode == false
    setupPIPController()
  }
  
  override func viewWillTransition(
    to size: CGSize,
    with coordinator: any UIViewControllerTransitionCoordinator
  ) {
    switchControlPannel(size: size)
    playerViewBottomConstraint.isActive = isLandscape(size: size)
    chattingView.textField.resignFirstResponder()
    
    if isLandscape(size: size) {
      chattingViewBottomConstraint.constant = chattingLandscapeConstraint
    } else {
      chattingViewBottomConstraint.constant = 0
    }
    
    coordinator.animate { _ in
      self.chattingView.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    super.viewWillTransition(to: size, with: coordinator)
  }
  
  private func setupPIPController() {
    // isPictureInPictureSupported() == true일 때, 제대로 동작 가능함
    guard AVPictureInPictureController.isPictureInPictureSupported(),
          let playerLayer = playerView.avPlayerLayer else {
      return
    }
    
    let pipController = AVPictureInPictureController(playerLayer: playerLayer)
    pipController?.canStartPictureInPictureAutomaticallyFromInline = true
    
    self.pipController = pipController
  }
  
  private func isLandscape(size: CGSize) -> Bool {
    return size.width > size.height
  }
  
  private func setupUI() {
    playerView.delegate = self
    seekbar.delegate = self
    chattingView.delegate = self

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
    playerView.set(url: video.videoURL)
    playerView.play()
    
    titleLabel.text = video.title
    landscapeTitleLabel.text = video.title
    channelThumnailImageView.loadImage(url: video.channelImageUrl)
    channelNameLabel.text = video.channel
    updateDateLabel.text = Self.dateFormatter.string(from: Date(timeIntervalSince1970: video.uploadTimestamp))
    playCountLabel.text = "재생수 \(video.playCount)"
    favoriteButton.setTitle("\(video.favoriteCount)", for: .normal)
    recommendTableView.reloadData()
  }
  
  @IBAction func didTapComment(_ sender: Any) {
    guard isLiveMode else { return }
    
    chattingView.isHidden = false
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
    rotateScene(landscape: true)
  }
  
  @IBAction func didTapShrink(_ sender: Any) {
    rotateScene(landscape: false)
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
    
    landscapePlayButton.setImage(
      isPlaying ? .bigPause : .bigPlay,
      for: .normal
    )
  }
  
  private func switchControlPannel(size: CGSize) {
    guard isControlPannelHidden == false else { return }
    
    landscapeControlPannel.isHidden = isLandscape(size: size) == false
    portraitControlPannel.isHidden = isLandscape(size: size)
  }
  
  private func rotateScene(landscape: Bool) {
    if #available(iOS 16.0, *) {
      view.window?.windowScene?.requestGeometryUpdate(
        .iOS(interfaceOrientations: landscape ? .landscapeRight : .portrait)
      )
    } else {
      // iOS 16 이전까지는 기기의 orientation 상태를 강제로 set해서 바꾸었음
      let orientation: UIInterfaceOrientation = landscape ? .landscapeRight : .portrait
      UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
      // device orientation에 맞춰서 화면을 돌림
      UIViewController.attemptRotationToDeviceOrientation()
    }
  }
}

// MARK: - PlayerViewDeleagte

extension VideoVC: PlayerviewDelegate {
  func playerViewReadyToPlay(_ playerView: PlayerView) {
    seekbar.setTotalPlayTime(playerView.totalPlayTime)
    updatePlayButton(isPlaying: playerView.isPlaying)
    updatePlayTime(0, totalPlayTime: playerView.totalPlayTime)
  }
  
  func playerView(
    _ playerView: PlayerView,
    didPlay playTime: Double,
    playableTime: Double
  ) {
    seekbar.setPlayTime(playTime, playableTime: playableTime)
    updatePlayTime(playTime, totalPlayTime: playerView.totalPlayTime)
  }
  
  func playerViewDidFinishToPlay(_ playerView: PlayerView) {
    playerView.seek(to: 0)
    updatePlayButton(isPlaying: false)
  }
  
  private func updatePlayTime(
    _ playTime: Double,
    totalPlayTime: Double
  ) {
    guard let playTimeText = DateComponentsFormatter.playTimeFormatter.string(from: playTime),
          let totalPlayTimeText = DateComponentsFormatter.playTimeFormatter.string(from: totalPlayTime)
    else {
      landscapePlayTimeLabel.text = nil
      return
    }
    
    landscapePlayTimeLabel.text = "\(playTimeText) / \(totalPlayTimeText)"
  }
}

// MARK: - SeekBarViewDelegate

extension VideoVC: SeekBarViewDelegate {
  func seekbar(
    _ seekbar: SeekbarView,
    seekToPercent percent: Double
  ) {
    playerView.seek(to: percent)
  }
}

// MARK: - ChattingViewDelegate

extension VideoVC: ChattingViewDelegate {
  func liveChattingViewdidTapClose(_ chattingView: ChattingView) {
    setEditing(false, animated: true)
    chattingView.isHidden = true
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
