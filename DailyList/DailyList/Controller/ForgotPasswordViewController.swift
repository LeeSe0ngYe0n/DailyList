import UIKit

final class ForgotPasswordViewController: UIViewController {
  private let forgotPasswordView: ForgotPasswordView = ForgotPasswordView()
  
  override func loadView() {
    self.view = forgotPasswordView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setButtonAddTarget()
  }
}

// MARK: - Add Target
extension ForgotPasswordViewController {
  private func setButtonAddTarget() {
    forgotPasswordView.setCancelButtonTarget(target: self, action: #selector(tappedCancelButton), for: .touchUpInside)
    forgotPasswordView.setSendButtonTarget(target: self, action: #selector(tappedSendButton), for: .touchUpInside)
  }
  
  @objc private func tappedCancelButton() {
    self.dismiss(animated: true)
  }
  
  @objc private func tappedSendButton() {
    print("tapped - tappedSendButton")
  }
}
