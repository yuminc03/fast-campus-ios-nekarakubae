import UIKit
import AVKit

protocol VideoVCDelegate: AnyObject {
  func videoVC(
    _ vc: VideoVC,
    yPositionForMinizeView height: CGFloat
  ) -> CGFloat
  
  func videoVCDidMinimize(_ vc: VideoVC)
  func videoVCNeedsMaximize(_ vc: VideoVC)
  func videoVCDidTapClose(_ vc: VideoVC)
}

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
  
  
  @IBOutlet weak var minimizePlayButton: UIButton!
  @IBOutlet weak var minimizeTitleLabel: UILabel!
  @IBOutlet weak var minimizeChannelLabel: UILabel!
  @IBOutlet weak var minimizePlayerView: PlayerView!
  @IBOutlet weak var minimizeView: UIView!
  @IBOutlet weak var minimizeViewBottomConstraint: NSLayoutConstraint!
  
  var isLiveMode = false
  weak var delegate: VideoVCDelegate?
  private var isMinimizeMode = false {
    didSet {
      minimizeView.isHidden = isMinimizeMode == false
    }
  }
  
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
    
    self.modalPresentationStyle = .custom
    self.transitioningDelegate = self
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    self.modalPresentationStyle = .custom
    self.transitioningDelegate = self
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
    minimizePlayerView.delegate = self
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
    minimizeTitleLabel.text = video.title
    minimizeChannelLabel.text = video.channel
    titleLabel.text = video.title
    landscapeTitleLabel.text = video.title
    channelThumnailImageView.loadImage(url: video.channelImageUrl)
    channelNameLabel.text = video.channel
    updateDateLabel.text = Self.dateFormatter.string(from: Date(timeIntervalSince1970: video.uploadTimestamp))
    playCountLabel.text = "재생수 \(video.playCount)"
    favoriteButton.setTitle("\(video.favoriteCount)", for: .normal)
    recommendTableView.reloadData()
  }
  
  @IBAction func maximize(_ sender: Any) {
    
  }
  
  @IBAction func didTapCloseMinimizeView(_ sender: Any) {
    
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
    isMinimizeMode = true
    rotateScene(landscape: false)
    dismiss(animated: true)
  }
  
  @IBAction func toggleControlPannel(_ sender: Any) {
    isControlPannelHidden.toggle()
  }
  
  private func updatePlayButton(isPlaying: Bool) {
    let playImage = UIImage(resource: isPlaying ? .smallPause : .smallPlay)
    playButton.setImage(playImage, for: .normal)
    minimizePlayButton.setImage(playImage, for: .normal)
    
    let landscapePlayImage = UIImage(resource: isPlaying ? .bigPause : .bigPlay)
    landscapePlayButton.setImage(landscapePlayImage, for: .normal)
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

// MARK: - UIViewControllerTransitioningDelegate

extension VideoVC: UIViewControllerTransitioningDelegate {
  func animationController(
    forPresented presented: UIViewController,
    presenting: UIViewController,
    source: UIViewController
  ) -> (any UIViewControllerAnimatedTransitioning)? {
    return self
  }
  
  func animationController(
    forDismissed dismissed: UIViewController
  ) -> (any UIViewControllerAnimatedTransitioning)? {
    return self
  }
}

extension VideoVC: UIViewControllerAnimatedTransitioning {
  /// 애니메이션이 몇 초동안 일어날 것인지 결정
  func transitionDuration(
    using transitionContext: (any UIViewControllerContextTransitioning)?
  ) -> TimeInterval {
    return 0.3
  }
  
  /// 애니메이션이 present, dismiss될 때를 구분해서 확인
  func animateTransition(
    using transitionContext: any UIViewControllerContextTransitioning
  ) {
    if isBeingPresented {
      // present 될 때
      
      // 전환이 일어날 view
      guard let view = transitionContext.view(forKey: .to) else { return }
      
      // 전환이 일어날 view를 보여줌
      transitionContext.containerView.addSubview(view)
      
      if isMinimizeMode {
        chattingViewBottomConstraint.constant = 0
        playerViewBottomConstraint.isActive = false
        playerView.isHidden = false
        minimizeViewBottomConstraint.isActive = false
        isMinimizeMode = false
        
        UIView.animate(
          withDuration: transitionDuration(using: transitionContext)
        ) {
          // view의 top까지 animation 넣기
          view.frame = .init(
            origin: .init(x: 0, y: view.safeAreaInsets.top),
            size: view.window?.frame.size ?? view.frame.size
          )
        } completion: { _ in
          view.frame.origin = .zero
          transitionContext.completeTransition(transitionContext.transitionWasCancelled == false)
        }
      } else {
        view.alpha = 0
        UIView.animate(
          withDuration: transitionDuration(using: transitionContext)
        ) {
          view.alpha = 1
        } completion: { _ in
          transitionContext.completeTransition(transitionContext.transitionWasCancelled == false)
        }
      }
    } else {
      // dismiss 될 때
      
      // 여기서 .view(forKey: .from)은 dismiss될 화면(지금 이 VideoVC의 view)
      guard let view = transitionContext.view(forKey: .from) else { return }
      
      if isMinimizeMode, let yPosition = delegate?.videoVC(
        self,
        yPositionForMinizeView: minimizeView.frame.height
      ) {
        // 재생 일시정지일 때 영상 player를 최소화 playerView로 control할 수 있게 연결
        minimizePlayerView.player = playerView.player
        isControlPannelHidden = true // 제어 패널 숨김
        // 채팅 bottomConstraint를 조정해서 playerView만 잘보이게 설정
        chattingViewBottomConstraint.constant = chattingLandscapeConstraint
        playerViewBottomConstraint.isActive = true
        playerView.isHidden = true
        
        // playerView가 위에서 자연스럽게 내려오도록 처리
        
        view.frame.origin.y = view.safeAreaInsets.top
        
        UIView.animate(
          withDuration: transitionDuration(using: transitionContext)
        ) { [weak self] in
          guard let self else { return }
          
          view.frame.origin.y = yPosition
          view.frame.size.height = minimizeView.frame.height
        } completion: { _ in
          // transition이 끝났음을 알려줌
          
          transitionContext.completeTransition(transitionContext.transitionWasCancelled == false)
          self.minimizeViewBottomConstraint.isActive = true
          self.delegate?.videoVCDidMinimize(self)
        }
      } else {
        UIView.animate(
          withDuration: transitionDuration(using: transitionContext)
        ) {
          view.alpha = 0
        } completion: { _ in
          transitionContext.completeTransition(transitionContext.transitionWasCancelled == false)
          view.alpha = 1
        }
      }
    }
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
