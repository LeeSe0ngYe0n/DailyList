import Foundation

struct AddTodoData: Codable {
  var title: String
  var isCompleted: Bool
  var date: Date
  
  enum CodingKeys: String, CodingKey {
    case title
    case isCompleted = "completed"
    case date
  }
}
