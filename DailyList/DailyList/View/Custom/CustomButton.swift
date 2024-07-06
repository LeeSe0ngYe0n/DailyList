import UIKit

final class CustomButton: UIButton {
  
  init(title: String) {
    super.init(frame: .zero)
    self.setTitle(title, for: .normal)
    self.setButton()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setButton() {
    self.setTitleColor(.white, for: .normal)
    self.backgroundColor = .black
    self.layer.opacity = 0.2
    self.layer.masksToBounds = true
    self.layer.cornerRadius = 30
    self.isEnabled = false
  }
}
