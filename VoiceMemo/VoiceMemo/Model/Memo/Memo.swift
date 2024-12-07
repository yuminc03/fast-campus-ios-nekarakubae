import Foundation

struct Memo: Hashable {
  let id = UUID()
  var title: String
  var content: String
  let date: Date
  
  var convertedDate: String {
    return String("\(date.formattedDay) - \(date.formattedTime)")
  }
}
