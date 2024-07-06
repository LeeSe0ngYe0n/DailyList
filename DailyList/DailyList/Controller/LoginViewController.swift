import UIKit

final class LoginViewController: UIViewController {
  private let loginView: LoginView = LoginView()
  
  override func loadView() {
    self.view = loginView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

// MARK: - Add Target
extension LoginViewController {
  private func setButtonAddTarget() {
    loginView.setForgotPasswordButtonTarget(target: self, action: #selector(tappedForgotPasswordButton), for: .touchUpInside)
    loginView.setNewCustomerButton(target: self, action: #selector(tappedForgotPasswordButton), for: .touchUpInside)
    loginView.setLoginButtonTarget(target: self, action: #selector(tappedLoginButton), for: .touchUpInside)
  }
  
  @objc private func tappedForgotPasswordButton() {
    //
  }
  
  @objc private func tappedNewCustomerButton() {
    //
  }
  
  @objc private func tappedLoginButton() {
    //
  }
}
