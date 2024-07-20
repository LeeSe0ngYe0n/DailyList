import UIKit

final class LoginViewController: UIViewController {
  private let loginView: LoginView = LoginView()
  
  override func loadView() {
    self.view = loginView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setButtonAddTarget()
  }
}

// MARK: - Add Target
extension LoginViewController {
  private func setButtonAddTarget() {
    loginView.setForgotPasswordButtonTarget(target: self, action: #selector(tappedForgotPasswordButton), for: .touchUpInside)
    loginView.setNewCustomerButton(target: self, action: #selector(tappedNewCustomerButton), for: .touchUpInside)
    loginView.setLoginButtonTarget(target: self, action: #selector(tappedLoginButton), for: .touchUpInside)
  }
  
  @objc private func tappedForgotPasswordButton() {
    let forgotPasswordViewController = ForgotPasswordViewController()
    self.present(forgotPasswordViewController, animated: true)
  }
  
  @objc private func tappedNewCustomerButton() {
    let newCustomerViewController = RegisterViewController()
    self.present(newCustomerViewController, animated: true)
  }
  
  @objc private func tappedLoginButton() {
    guard
      let email = loginView.getEmailText(),
      let password = loginView.getPasswordText()
    else {
      return
    }
    
    let loginData = LoginData(email: email, password: password)
    let endpoint = LoginEndpoint(loginData: loginData)
    
    Task {
      do {
        let responseData = try await NetworkService.shared.makeURLRequest(endpoint: endpoint)
        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: responseData)
        print("userId - ",loginResponse.userId)
        if loginResponse.message == "Login successful" {
          UserDefaults.standard.set(loginResponse.userId, forKey: "user_id")
          loginView.textFieldTextClear()
          nextCategoryViewController()
        } else {
          print("Login failed: \(loginResponse)")
        }
      } catch {
        print("login error - \(error)")
        loginView.getCheckEmailAndPasswordPhrase()
      }
    }
  }
}

// MARK: - Private Function
extension LoginViewController {
  private func nextCategoryViewController() {
    let categoryViewController: CategoryViewController = CategoryViewController()
    self.navigationController?.pushViewController(categoryViewController, animated: true)
  }
}
