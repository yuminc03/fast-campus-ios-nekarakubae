import UIKit

final class MyVC: UIViewController {
  
  @IBOutlet weak var profileImageView: UIImageView!
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
  }
  
  private func setupUI() {
    profileImageView.layer.cornerRadius = 5
  }
}
