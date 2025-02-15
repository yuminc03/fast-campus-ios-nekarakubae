import UIKit

final class LiveVC: UIViewController {
  
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var favoriteButton: UIButton!
  @IBOutlet weak var startTimeButton: UIButton!
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .portrait
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
  }
  
  @IBAction func didTapSort(_ sender: UIButton) {
    guard sender.isSelected == false else { return }
    
    favoriteButton.isSelected = sender == favoriteButton
    startTimeButton.isSelected = sender == startTimeButton
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
    return 10
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
    
    return cell
  }
}
