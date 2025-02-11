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
  
  @IBAction func didTapSort(_ sender: Any) {
    
  }
  
  private func setupUI() {
    containerView.layer.cornerRadius = 15
    containerView.layer.borderColor = UIColor(resource: .gray2).cgColor
    containerView.layer.borderWidth = 1
  }
}
