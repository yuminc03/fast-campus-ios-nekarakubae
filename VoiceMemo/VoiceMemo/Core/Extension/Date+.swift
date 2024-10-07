import Foundation

extension Date {
  /// 날짜 형식 설정 - ex) 오후 03:00
  var formattedTime: String {
    let formatter = DateFormatter()
    formatter.locale = .init(identifier: "ko_KR")
    formatter.dateFormat = "a hh:mm"
    return formatter.string(from: self)
  }
  
  /// 오늘 날짜면 '오늘'로 표시하고 다른 날짜면 날짜(ex: 5월 16일 금요일)를 표시함
  var formattedDay: String {
    let now = Date()
    let calendar = Calendar.current
    let nowStartOfDay = calendar.startOfDay(for: now)
    let dateStartOfDay = calendar.startOfDay(for: self)
    guard let numOfDaysDiffrence = calendar.dateComponents([.day], from: nowStartOfDay, to: dateStartOfDay).day else {
      print("formattedDay 구하기 실패")
      return "\(Date().formattedDay)"
    }
    
    if numOfDaysDiffrence == 0 {
      return "오늘"
    } else {
      let formatter = DateFormatter()
      formatter.locale = .init(identifier: "ko_KR")
      formatter.dateFormat = "M월 d일 E요일"
      return formatter.string(from: self)
    }
  }
}
