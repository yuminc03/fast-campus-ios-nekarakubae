import UIKit

final class LoginVC: UIViewController {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var loginButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
  }
  
  private func setupUI() {
    loginButton.layer.cornerRadius = 20
    loginButton.layer.borderColor = UIColor(resource: .mainBrown).cgColor
    loginButton.layer.borderWidth = 1
  }
  
  @IBAction func didTapLoginButton(_ sender: Any) {
    view.window?.rootViewController = storyboard?.instantiateViewController(withIdentifier: "tabBar")
  }
}

