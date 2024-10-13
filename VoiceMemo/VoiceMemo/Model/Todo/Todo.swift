import Foundation

/// 할 일 목록
struct Todo: Hashable {
  let title: String
  let time: Date
  let day: Date
  var selected: Bool
  
  var convertedDayAndTime: String {
    // 오늘 - 오후 03:00에 알림
    String("\(day.formattedDay) - \(time.formattedTime)에 알림")
  }
}
