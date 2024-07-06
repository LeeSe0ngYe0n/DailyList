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
