import UIKit

final class MoreVC: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var headerView: UIView!
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    
    self.modalPresentationStyle = .overFullScreen
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    self.modalPresentationStyle = .overFullScreen
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func didTapClose(_ sender: Any) {
    dismiss(animated: false)
  }
}
