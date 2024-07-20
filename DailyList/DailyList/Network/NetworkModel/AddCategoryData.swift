struct AddCategoryData: Codable {
  let userId: Int
  let categoryName: String
  let icon: String
  let color: String
  
  enum CodingKeys: String, CodingKey {
    case categoryName = "name"
    case icon
    case userId = "user_id"
    case color
  }
}
