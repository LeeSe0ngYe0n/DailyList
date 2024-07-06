import UIKit

final class TextFieldUnderline: UITextField {
  private let underlineLayer = CALayer()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addUnderline()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension TextFieldUnderline {
  private func addUnderline() {
    underlineLayer.backgroundColor = UIColor.systemGray.cgColor
    layer.addSublayer(underlineLayer)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    underlineLayer.frame = CGRect(x: 0, y: bounds.height + 7, width: bounds.width, height: 1)
  }
}

