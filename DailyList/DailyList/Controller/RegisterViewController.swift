import UIKit

final class RegisterViewController: UIViewController {
  private let registerView: RegisterView = RegisterView()
  
  override func loadView() {
    self.view = registerView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setButtonAddTarget()
  }
}

// MARK: - Add Target
extension RegisterViewController {
  private func setButtonAddTarget() {
    registerView.setCancelButtonTarget(target: self, action: #selector(tappedCancelButton), for: .touchUpInside)
    registerView.setCreateAccountButtonTarget(target: self, action: #selector(tappedCreateAccountButton), for: .touchUpInside)
  }
  
  @objc private func tappedCancelButton() {
    self.dismiss(animated: true)
  }
  
  @objc private func tappedCreateAccountButton() {
    guard
      let userName = registerView.getName(),
      let email = registerView.getEmail(),
      let password = registerView.getPassword()
    else {
      return
    }
  
    Task {
      do {
        let endpoint = RegisterEndpoint(username: userName, email: email, password: password)
        try await NetworkService.shared.makeURLRequest(endpoint: endpoint)
      } catch {
        print("register error - \(error)")
      }
    }
    self.dismiss(animated: true)
  }
}

