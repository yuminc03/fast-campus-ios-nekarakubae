import UIKit

final class LiveVC: UIViewController {
  
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var favoriteButton: UIButton!
  @IBOutlet weak var startTimeButton: UIButton!
  
  private let vm = LiveVM()
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .portrait
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    bind()
  }
  
  @IBAction func didTapSort(_ sender: UIButton) {
    guard sender.isSelected == false else { return }
    
    favoriteButton.isSelected = sender == favoriteButton
    startTimeButton.isSelected = sender == startTimeButton
    
    vm.request(sort: favoriteButton.isSelected ? .favorite : .start)
  }
  
  private func setupUI() {
    containerView.layer.cornerRadius = 15
    containerView.layer.borderColor = UIColor(resource: .gray2).cgColor
    containerView.layer.borderWidth = 1
    
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(
      UINib(nibName: LiveCell.id, bundle: nil),
      forCellWithReuseIdentifier: LiveCell.id
    )
  }
  
  private func bind() {
    vm.dataChanged = { [weak self] _ in
      self?.collectionView.reloadData()
      self?.collectionView.setContentOffset(.zero, animated: true) // scroll을 맨 위로 올리기
    }
    
    vm.request(sort: .favorite)
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension LiveVC: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    return .init(
      width: collectionView.frame.width,
      height: LiveCell.height
    )
  }
}

// MARK: - UICollectionViewDataSource

extension LiveVC: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return vm.items?.count ?? 0
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: LiveCell.id,
      for: indexPath
    ) as? LiveCell else {
      return UICollectionViewCell()
    }
    
    if let data = vm.items?[indexPath.item] {
      cell.setData(data)
    }
    
    return cell
  }
}
