import Foundation

struct TodoData: Codable {
    let id: Int
    let title: String
    var isCompleted: Bool
//    let dueDate: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case isCompleted = "completed"
//        case dueDate = "date"
    }
}

