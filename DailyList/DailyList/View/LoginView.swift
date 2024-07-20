import UIKit

final class LoginView: UIView {
  private lazy var loginLabel: UILabel = {
    let lb: UILabel = UILabel()
    lb.text = "DailyList"
    lb.textColor = .black
    lb.font = .preferredFont(forTextStyle: .largeTitle)
    lb.textAlignment = .center
    self.addSubview(lb)
    return lb
  }()
  
  private lazy var emailTextField: TextFieldUnderline = {
    let tf = TextFieldUnderline()
    tf.placeholder = "Email"
    tf.keyboardType = .emailAddress
    tf.autocorrectionType = .no
    tf.spellCheckingType = .no
    tf.addTarget(self, action: #selector(loginButtonEnabled), for: .editingChanged)
    self.addSubview(tf)
    return tf
  }()
  
  private lazy var passwordTextField: TextFieldUnderline = {
    let tf = TextFieldUnderline()
    tf.placeholder = "Password"
    tf.keyboardType = .default
    tf.autocorrectionType = .no
    tf.spellCheckingType = .no
    tf.isSecureTextEntry = true
    tf.addTarget(self, action: #selector(loginButtonEnabled), for: .editingChanged)
    self.addSubview(tf)
    return tf
  }()
  
  private lazy var forgotPasswordButton: UIButton = {
    let bt: UIButton = UIButton()
    bt.setTitle("Forgot Password", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    bt.titleLabel?.font = .preferredFont(forTextStyle: .subheadline)
    self.addSubview(bt)
    return bt
  }()
  
  private lazy var newCustomerButton: UIButton = {
    let bt: UIButton = UIButton()
    bt.setTitle("New Customer", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    bt.titleLabel?.font = .preferredFont(forTextStyle: .subheadline)
    self.addSubview(bt)
    return bt
  }()
  
  private lazy var checkEmailAndPasswordLabel: UILabel = {
    let lb: UILabel = UILabel()
    lb.textColor = .systemRed
    lb.font = .preferredFont(forTextStyle: .footnote)
    lb.textAlignment = .center
    self.addSubview(lb)
    return lb
  }()
  
  private lazy var loginButton: CustomButton = {
    let bt = CustomButton(title: "Login")
    self.addSubview(bt)
    return bt
  }()
  
  private lazy var textFieldStackView: UIStackView = {
    let sv: UIStackView = UIStackView()
    sv.addArrangedSubview(emailTextField)
    sv.addArrangedSubview(passwordTextField)
    sv.axis = .vertical
    sv.spacing = 35
    self.addSubview(sv)
    return sv
  }()
  
  private lazy var forgotPasswordAndNewCustomerStackView: UIStackView = {
    let sv: UIStackView = UIStackView()
    sv.addArrangedSubview(forgotPasswordButton)
    sv.addArrangedSubview(newCustomerButton)
    sv.axis = .horizontal
    sv.distribution = .fillEqually
    sv.spacing = 10
    self.addSubview(sv)
    return sv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .white
    setAutoLayout()
    setTextFieldDelegate()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.endEditing(true)
  }
  
  private func setTextFieldDelegate() {
    emailTextField.delegate = self
    passwordTextField.delegate = self
  }
  
  @objc private func loginButtonEnabled(_ textfield: UITextField) {
    guard
      let email = emailTextField.text,
      let password = passwordTextField.text
    else {
      return
    }
    
    if !email.isEmpty && !password.isEmpty {
      loginButton.layer.opacity = 1
      loginButton.isEnabled = true
    } else {
      loginButton.layer.opacity = 0.2
      loginButton.isEnabled = false
    }
  }
  
  // MARK: AutoLayout
  private func setAutoLayout() {
    loginLabel.translatesAutoresizingMaskIntoConstraints = false
    textFieldStackView.translatesAutoresizingMaskIntoConstraints = false
    forgotPasswordAndNewCustomerStackView.translatesAutoresizingMaskIntoConstraints = false
    checkEmailAndPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
    loginButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      loginLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 200),
      loginLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 100),
      loginLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100),
      
      textFieldStackView.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 40),
      textFieldStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
      textFieldStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
      
      forgotPasswordAndNewCustomerStackView.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 20),
      forgotPasswordAndNewCustomerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 55),
      forgotPasswordAndNewCustomerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -55),
      
      checkEmailAndPasswordLabel.topAnchor.constraint(equalTo: forgotPasswordAndNewCustomerStackView.bottomAnchor, constant: 4),
      checkEmailAndPasswordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
      checkEmailAndPasswordLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
      
      loginButton.topAnchor.constraint(equalTo: checkEmailAndPasswordLabel.bottomAnchor, constant: 15),
      loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
      loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
      loginButton.heightAnchor.constraint(equalToConstant: 60)
    ])
  }
}

// MARK: TextField Delegate
extension LoginView: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}

// MARK: - Add Target
extension LoginView {
  func setForgotPasswordButtonTarget(target: Any?, action: Selector, for event: UIControl.Event) {
    forgotPasswordButton.addTarget(target, action: action, for: event)
  }
  
  func setNewCustomerButton(target: Any?, action: Selector, for event: UIControl.Event) {
    newCustomerButton.addTarget(target, action: action, for: event)
  }
  
  func setLoginButtonTarget(target: Any?, action: Selector, for event: UIControl.Event) {
    loginButton.addTarget(target, action: action, for: event)
  }
}

// MARK: - Function
extension LoginView {
  func textFieldTextClear() {
    checkEmailAndPasswordLabel.text = ""
    emailTextField.text = ""
    passwordTextField.text = ""
    loginButton.isEnabled = false
    loginButton.layer.opacity = 0.2
    loginButton.layer.masksToBounds = true
  }
  
  func getEmailText() -> String? {
    return emailTextField.text
  }
  
  func getPasswordText() -> String? {
    return passwordTextField.text
  }
  
  func getCheckEmailAndPasswordPhrase() {
    checkEmailAndPasswordLabel.text = "! Please check your Email and Password."
  }
}

