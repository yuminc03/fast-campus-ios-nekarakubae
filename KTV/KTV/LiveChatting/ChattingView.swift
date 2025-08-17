import UIKit

protocol ChattingViewDelegate: AnyObject {
  func liveChattingViewdidTapClose(_ chattingView: ChattingView)
}

final class ChattingView: UIView {
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var textField: UITextField!
  
  weak var delegate: ChattingViewDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupUI()
  }
  
  private func setupUI() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(
      UINib(nibName: LiveChattingMessageCollectionViewCell.identifier, bundle: nil),
      forCellWithReuseIdentifier: LiveChattingMessageCollectionViewCell.identifier
    )
    
    collectionView.register(
      UINib(nibName: LiveChattingMyMessageCollectionViewCell.identifier, bundle: nil),
      forCellWithReuseIdentifier: LiveChattingMyMessageCollectionViewCell.identifier
    )
  }
  
  @IBAction func didTapClose(_ sender: Any) {
    textField.resignFirstResponder()
    delegate?.liveChattingViewdidTapClose(self)
  }
  
  @IBAction func dismissKeyboard(_ sender: Any) {
    textField.resignFirstResponder()
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ChattingView: UICollectionViewDelegateFlowLayout {
  
}

// MARK: - UICollectionViewDataSource

extension ChattingView: UICollectionViewDataSource {
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
    return UICollectionViewCell()
  }
  
  
}
