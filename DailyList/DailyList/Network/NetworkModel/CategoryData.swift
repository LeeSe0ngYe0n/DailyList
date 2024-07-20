struct CategoryData: Codable {
  let name: String
  let icon: String
  let userId: Int
  let color: String
  let categoryId: Int
  
  enum CodingKeys: String, CodingKey {
    case name
    case icon
    case userId = "user_id"
    case color
    case categoryId = "category_id"
  }
}
