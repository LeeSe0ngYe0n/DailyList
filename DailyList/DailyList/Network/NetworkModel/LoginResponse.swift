struct LoginResponse: Codable {
    let message: String
    let userId: Int
  
  enum CodingKeys: String, CodingKey {
    case message
    case userId = "user_id"
  }
}
