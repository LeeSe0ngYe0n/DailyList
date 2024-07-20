enum IconName: CaseIterable {
  case book
  case heart
  case cart
  case laptop
  case person
  
  var icon: String {
    switch self {
    case .book:
      "book"
    case .heart:
      "heart"
    case .cart:
      "cart"
    case .laptop:
      "macbook"
    case .person:
      "person"
    }
  }
}
