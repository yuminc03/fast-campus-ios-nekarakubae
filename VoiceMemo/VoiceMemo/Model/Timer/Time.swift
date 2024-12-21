import Foundation

struct Time {
  let hours: Int
  let minutes: Int
  let seconds: Int
  
  var convertedSeconds: Int {
    return (hours * 3600) + (minutes * 60) + seconds
  }
  
  static func fromSeconds(_ seconds: Int) -> Time {
    let hours = seconds / 3600
    let minutes = (seconds % 3600) / 60
    let remainingSeconds = (seconds % 3600) % 60
    return .init(hours: hours, minutes: minutes, seconds: remainingSeconds)
  }
}
