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
  
  
  @IBAction func didTapFavorite(_ sender: Any) {
    performSegue(withIdentifier: "favorite", sender: nil)
  }
  
  private func setupUI() {
    profileImageView.layer.cornerRadius = 5
  }
}
