import Foundation

struct Memo: Hashable {
  let id = UUID()
  let title: String
  let content: String
  let date: Date
  
  var convertedDate: String {
    return String("\(date.formattedDay) - \(date.formattedTime)")
  }
}
