import Foundation
import UIKit

final class TimerVM: ObservableObject {
  @Published var isDisplaySetTimeView: Bool // time picker가 나타났는지 여부
  @Published var time: Time
  @Published var timer: Timer?
  @Published var timeRemaining: Int
  @Published var isPaused: Bool
  var notificationService: NotificationService
  
  init(
    isDisplaySetTimeView: Bool = true,
    time: Time = .init(hours: 0, minutes: 0, seconds: 0),
    timer: Timer? = nil,
    timeRemaining: Int = 0,
    isPaused: Bool = false,
    notificationService: NotificationService = .init()
  ) {
    self.isDisplaySetTimeView = isDisplaySetTimeView
    self.time = time
    self.timer = timer
    self.timeRemaining = timeRemaining
    self.isPaused = isPaused
    self.notificationService = notificationService
  }
}

extension TimerVM {
  func didTapSettingButton() {
    isDisplaySetTimeView = false
    timeRemaining = time.convertedSeconds
    startTimer()
  }
  
  func didTapCancelButton() {
    stopTimer()
    isDisplaySetTimeView = true
  }
  
  func didTapPauseOrRestartButton() {
    if isPaused {
      startTimer()
    } else {
      timer?.invalidate()
      timer = nil
    }
    
    isPaused.toggle()
  }
}

private extension TimerVM {
  func startTimer() {
    guard timer == nil else { return }
    
    // 앱이 background로 전환되었을 때 일부 작업을 수행할 수 있게 하는 메서드
    var backgroundTaskID: UIBackgroundTaskIdentifier?
    backgroundTaskID = UIApplication.shared.beginBackgroundTask { // 나중에 background 작업을 종료하기 위해서 사용함
      // expired handler는 iOS 시스템이 앱에 할당한 background 실행시간이 소진되어갈 때 호출
      if let task = backgroundTaskID {
        UIApplication.shared.endBackgroundTask(task) // background 작업 종료
        backgroundTaskID = .invalid // 변수 무효화
      }
    }
    
    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
      guard let self else { return }
      
      if timeRemaining > 0 {
        timeRemaining -= 1
      } else {
        stopTimer()
        notificationService.sendNotification()
        
        if let task = backgroundTaskID {
          UIApplication.shared.endBackgroundTask(task)
          backgroundTaskID = .invalid
        }
      }
    }
  }
  
  func stopTimer() {
    timer?.invalidate()
    timer = nil
  }
}
