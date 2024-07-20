import UIKit

extension String {
  func strikeThrough() -> NSAttributedString {
    let attributeString = NSMutableAttributedString(string: self)
    attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                 value: NSUnderlineStyle.single.rawValue,
                                 range: NSMakeRange(0, attributeString.length))
    return attributeString
  }
  
  func dateAsString() -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: self)
  }
}
