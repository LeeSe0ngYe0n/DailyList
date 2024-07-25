import UIKit

final class RegisterView: UIView {
  private lazy var cancelButton: UIButton = {
    let bt: UIButton = UIButton()
    bt.setTitle("Cancel", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    self.addSubview(bt)
    return bt
  }()
  
  private lazy var mainLabel: UILabel = {
    let lb: UILabel = UILabel()
    lb.text = "Create An Account"
    lb.textColor = .black
    lb.font = .preferredFont(forTextStyle: .title1)
    lb.textAlignment = .center
    self.addSubview(lb)
    return lb
  }()
  
  private lazy var subLabel: UILabel = {
    let lb: UILabel = UILabel()
    lb.numberOfLines = 4
    lb.font = .preferredFont(forTextStyle: .footnote)
    lb.text = "Need some information to Create An Account."
    lb.textAlignment = .center
    self.addSubview(lb)
    return lb
  }()
  
  private lazy var nameTextField: TextFieldUnderline = {
    let tf = TextFieldUnderline()
    tf.placeholder = "Name"
    tf.autocorrectionType = .no
    tf.spellCheckingType = .no
    tf.addTarget(self, action: #selector(creatAccountButtonEnabled), for: .editingChanged)
    return tf
  }()
  
  private lazy var emailTextField: TextFieldUnderline = {
    let tf = TextFieldUnderline()
    tf.placeholder = "Email"
    tf.keyboardType = .emailAddress
    tf.autocorrectionType = .no
    tf.spellCheckingType = .no
    tf.addTarget(self, action: #selector(creatAccountButtonEnabled), for: .editingChanged)
    return tf
  }()
  
  private lazy var passwordTextField: TextFieldUnderline = {
    let tf = TextFieldUnderline()
    tf.placeholder = "Password"
    tf.keyboardType = .emailAddress
    tf.autocorrectionType = .no
    tf.spellCheckingType = .no
    tf.isSecureTextEntry = true
    tf.addTarget(self, action: #selector(creatAccountButtonEnabled), for: .editingChanged)
    return tf
  }()
  
  private lazy var checkPasswordTextField: TextFieldUnderline = {
    let tf = TextFieldUnderline()
    tf.placeholder = "Check Password"
    tf.keyboardType = .emailAddress
    tf.autocorrectionType = .no
    tf.spellCheckingType = .no
    tf.isSecureTextEntry = true
    tf.addTarget(self, action: #selector(creatAccountButtonEnabled), for: .editingChanged)
    return tf
  }()
  
  private lazy var passwordCheckLabel: UILabel = {
    let lb: UILabel = UILabel()
    lb.textColor = .systemRed
    lb.font = .preferredFont(forTextStyle: .footnote)
    lb.textAlignment = .center
    self.addSubview(lb)
    return lb
  }()
  
  private lazy var createAccountButton: CustomButton = {
    let bt = CustomButton(title: "Create Account")
    self.addSubview(bt)
    return bt
  }()
  
  private lazy var textFieldStackView: UIStackView = {
    let sv: UIStackView = UIStackView(arrangedSubviews: [
      nameTextField,
      emailTextField,
      passwordTextField,
      checkPasswordTextField
    ])
    sv.axis = .vertical
    sv.spacing = 35
    self.addSubview(sv)
    return sv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .white
    setAutolayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.endEditing(true)
  }
}

// MARK: - Autolayout
extension RegisterView {
  private func setAutolayout() {
    cancelButton.translatesAutoresizingMaskIntoConstraints = false
    mainLabel.translatesAutoresizingMaskIntoConstraints = false
    subLabel.translatesAutoresizingMaskIntoConstraints = false
    textFieldStackView.translatesAutoresizingMaskIntoConstraints = false
    passwordCheckLabel.translatesAutoresizingMaskIntoConstraints = false
    createAccountButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      cancelButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
      cancelButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
      
      mainLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 150),
      mainLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
      mainLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
      
      subLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 15),
      subLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
      subLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
      
      textFieldStackView.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 50),
      textFieldStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
      textFieldStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
      
      passwordCheckLabel.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 24),
      passwordCheckLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
      passwordCheckLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
      
      createAccountButton.topAnchor.constraint(equalTo: passwordCheckLabel.bottomAnchor, constant: 14),
      createAccountButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
      createAccountButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
      createAccountButton.heightAnchor.constraint(equalToConstant: 60)
    ])
  }
}

// MARK: - Private Function
extension RegisterView {
  private func isCheckPassword(password: String, checkPassword: String) -> Bool {
    if password == checkPassword {
      return true
    } else {
      return false
    }
  }
  
  @objc private func creatAccountButtonEnabled(_ textfield: UITextField) {
    guard
      let name = nameTextField.text,
      let email = emailTextField.text,
      let password = passwordTextField.text,
      let checkPassword = checkPasswordTextField.text
    else {
      return
    }
    
    if isCheckPassword(password: password, checkPassword: checkPassword) {
      passwordCheckLabel.text = ""
    } else {
      passwordCheckLabel.text = "! Please check your Password."
    }
    
    if !name.isEmpty && !email.isEmpty && !password.isEmpty && !checkPassword.isEmpty && isCheckPassword(password: password, checkPassword: checkPassword) {
      createAccountButton.layer.opacity = 1
      createAccountButton.isEnabled = true
    } else {
      createAccountButton.layer.opacity = 0.2
      createAccountButton.isEnabled = false
    }
  }
}

// MARK: - AddTarget
extension RegisterView {
  func setCancelButtonTarget(target: Any?, action: Selector, for event: UIControl.Event) {
    cancelButton.addTarget(target, action: action, for: event)
  }
  
  func setCreateAccountButtonTarget(target: Any?, action: Selector, for event: UIControl.Event) {
    createAccountButton.addTarget(target, action: action, for: event)
  }
}

// MARK: - Function
extension RegisterView {
  func getName() -> String? {
    return nameTextField.text
  }
  
  func getEmail() -> String? {
    return emailTextField.text
  }
  
  func getPassword() -> String? {
    return checkPasswordTextField.text
  }
}
