import UIKit

protocol ChattingViewDelegate: AnyObject {
  func liveChattingViewdidTapClose(_ chattingView: ChattingView)
}

final class ChattingView: UIView {
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var textField: UITextField!
  
  weak var delegate: ChattingViewDelegate?
  
  private let vm = ChattingVM()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupUI()
    bind()
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
    
    textField.delegate = self
    textField.attributedPlaceholder = NSAttributedString(
      string: "채팅에 참여하세요!",
      attributes: [
        .foregroundColor: UIColor(named: "chat-text") ?? .clear,
        .font: UIFont.systemFont(ofSize: 12, weight: .medium)
      ]
    )
  }
  
  private func bind() {
    vm.chatReceived = { [weak self] in
      self?.collectionView.reloadData()
      self?.scrollToLatestIfNeeded()
    }
  }
  private func scrollToLatestIfNeeded() {
    let isBottomOffset = collectionView.bounds.maxY >= collectionView.contentSize.height - 200
    let isLastMessageMine = vm.messages.last?.isMine == true
    
    if isBottomOffset || isLastMessageMine {
      collectionView.scrollToItem(
        at: IndexPath(item: vm.messages.count - 1, section: 0),
        at: .bottom,
        animated: true
      )
    }
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
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let item = vm.messages[indexPath.item]
    let width = collectionView.frame.width - 32
    
    if item.isMine {
      return LiveChattingMyMessageCollectionViewCell.size(width: width, text: item.text)
    } else {
      return LiveChattingMessageCollectionViewCell.size(width: width, text: item.text)
    }
  }
}

// MARK: - UICollectionViewDataSource

extension ChattingView: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return vm.messages.count
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let item = vm.messages[indexPath.item]
    
    if item.isMine {
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: LiveChattingMyMessageCollectionViewCell.identifier,
        for: indexPath
      ) as? LiveChattingMyMessageCollectionViewCell else {
        return UICollectionViewCell()
      }
      
      cell.setText(item.text)
      
      return cell
    } else {
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: LiveChattingMessageCollectionViewCell.identifier,
        for: indexPath
      ) as? LiveChattingMessageCollectionViewCell else {
        return UICollectionViewCell()
      }
      
      cell.setText(item.text)
      
      return cell
    }
  }
}

// MARK: - UITextFieldDelegate

extension ChattingView: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    guard let text = textField.text, text.isEmpty == false else {
      return false
    }
    
    vm.sendMessage(text)
    textField.text = nil
    
    return true
  }
}
