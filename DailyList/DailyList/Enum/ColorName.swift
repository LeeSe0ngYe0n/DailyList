enum ColorName: CaseIterable {
  case black
  case red
  case orange
  case green
  case blue
  
  var color: String {
    switch self {
    case .black:
      "#000000"
    case .red:
      "#FF0000"
    case .orange:
      "#FFA500"
    case .green:
      "#008000"
    case .blue:
      "#0000FF"
    }
  }
}

