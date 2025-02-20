import UIKit

protocol ChattingViewDelegate: AnyObject {
  func liveChattingViewdidTapClose(_ chattingView: ChattingView)
}

final class ChattingView: UIView {
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var textField: UITextField!
  weak var delegate: ChattingViewDelegate?
  
  override class func awakeFromNib() {
    super.awakeFromNib()
  }
  
  @IBAction func didTapClose(_ sender: Any) {
    textField.resignFirstResponder()
    delegate?.liveChattingViewdidTapClose(self)
  }
  
  @IBAction func dismissKeyboard(_ sender: Any) {
    textField.resignFirstResponder()
  }
}
