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
    registerView.cancelButton.addTarget(self, action: #selector(tappedCancelButton), for: .touchUpInside)
    registerView.creatAccountButton.addTarget(self, action: #selector(tappedCreateAccountButton), for: .touchUpInside)
  }
  
  @objc private func tappedCancelButton() {
    self.dismiss(animated: true)
  }
  
  @objc private func tappedCreateAccountButton() {
    guard
      let userName = registerView.nameTextField.text,
      let email = registerView.emailTextField.text,
      let password = registerView.checkPasswordTextField.text
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

