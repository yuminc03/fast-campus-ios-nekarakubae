import Foundation

final class MemoListVM: ObservableObject {
  @Published var memos: [Memo]
  /// 현재 편집 모드인지 여부
  @Published var isEditMemoMode: Bool
  @Published var removeMemos: [Memo]
  @Published var isDisplayRemoveMemoAlert: Bool
  
  /// 삭제될 memo의 수
  var removeMemoCount: Int {
    return removeMemos.count
  }
  
  var navigationBarRightButtonMode: NavigationButtonType {
    return isEditMemoMode ? .complete : .edit
  }
  
  init(
    memos: [Memo] = [],
    isEditMemoMode: Bool = false,
    removeMemos: [Memo] = [],
    isDisplayRemoveMemoAlert: Bool = false
  ) {
    self.memos = memos
    self.isEditMemoMode = isEditMemoMode
    self.removeMemos = removeMemos
    self.isDisplayRemoveMemoAlert = isDisplayRemoveMemoAlert
  }
}

extension MemoListVM {
  func addMemo(_ memo: Memo) {
    self.memos.append(memo)
  }
  
  func updateMemo(_ memo: Memo) {
    if let index = memos.firstIndex(where: { $0.id == memo.id }) {
      memos[index] = memo
    }
  }
  
  func removeMemo(_ memo: Memo) {
    if let index = memos.firstIndex(where: { $0.id == memo.id }) {
      memos.remove(at: index)
    }
  }
  
  func didTapNavigationRightButton() {
    if isEditMemoMode {
      if removeMemos.isEmpty {
        isEditMemoMode = false
      } else {
        setIsDisplayRemoveMemoAlert(true)
      }
    } else {
      isEditMemoMode = true
    }
  }
  
  func setIsDisplayRemoveMemoAlert(_ isDisplay: Bool) {
    self.isDisplayRemoveMemoAlert = isDisplay
  }
  
  func didTapMemoRemoveSelectedBox(_ memo: Memo) {
    if let index = removeMemos.firstIndex(of: memo) {
      removeMemos.remove(at: index)
    } else {
      removeMemos.append(memo)
    }
  }
  
  func didTapRemoveButton() {
    memos.removeAll { removeMemos.contains($0) }
    removeMemos.removeAll()
    isEditMemoMode = false
  }
}
