import Foundation

final class HomeVM: ObservableObject {
  @Published var selectedTab: Tab
  @Published var todosCount: Int
  @Published var memosCount: Int
  @Published var voiceRecorderCount: Int
  
  init(
    selectedTab: Tab = .voiceRecorder,
    todosCount: Int = 0,
    memosCount: Int = 0,
    voiceRecorderCount: Int = 0
  ) {
    self.selectedTab = selectedTab
    self.todosCount = todosCount
    self.memosCount = memosCount
    self.voiceRecorderCount = voiceRecorderCount
  }
}

extension HomeVM {
  func setTodosCount(_ count: Int) {
    self.todosCount = count
  }
  
  func setMemoCount(_ count: Int) {
    self.memosCount = count
  }
  
  func setVoiceRecorderCount(_ count: Int) {
    self.voiceRecorderCount = count
  }
  
  func changeSelectedTab(_ tab: Tab) {
    self.selectedTab = tab
  }
}
