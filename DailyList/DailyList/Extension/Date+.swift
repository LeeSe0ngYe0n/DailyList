import Foundation

extension Date {
  static func todayAsString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    return dateFormatter.string(from: Date())
  }
}
