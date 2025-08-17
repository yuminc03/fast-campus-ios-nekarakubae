import Foundation

@MainActor
final class ChattingVM {
  private let chatSimulator = ChatSimulator()
  private(set) var messages: [ChatMessage] = []
  var chatReceived: (() -> Void)?
   
  init() {
    self.chatSimulator.setMessageHandler { [weak self] in
      self?.messages.append($0)
      self?.chatReceived?()
    }
  }
  
  func start() {
    chatSimulator.start()
  }
  
  func stop() {
    chatSimulator.stop()
  }
  
  func sendMessage(_ message: String) {
    chatSimulator.sendMessage(message)
  }
}
