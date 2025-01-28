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
  
  @IBAction func didTapBookmark(_ sender: Any) {
    
  }
  
  @IBAction func didTapFavoirte(_ sender: Any) {
    
  }
  
  private func setupUI() {
    profileImageView.layer.cornerRadius = 5
  }
}
