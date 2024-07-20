import UIKit

final class RegisterView: UIView {
  lazy var cancelButton: UIButton = {
    let bt: UIButton = UIButton()
    bt.setTitle("Cancel", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    self.addSubview(bt)
    return bt
  }()
  
  lazy var mainLabel: UILabel = {
    let lb: UILabel = UILabel()
    lb.text = "Create An Account"
    lb.textColor = .black
    lb.font = .preferredFont(forTextStyle: .title1)
    lb.textAlignment = .center
    self.addSubview(lb)
    return lb
  }()
  
  lazy var subLabel: UILabel = {
    let lb: UILabel = UILabel()
    lb.numberOfLines = 4
    lb.font = .preferredFont(forTextStyle: .footnote)
    lb.text = "Need some information to Create An Account."
    lb.textAlignment = .center
    self.addSubview(lb)
    return lb
  }()
  
  lazy var nameTextField: TextFieldUnderline = {
    let tf = TextFieldUnderline()
    tf.placeholder = "Name"
    tf.autocorrectionType = .no
    tf.spellCheckingType = .no
    tf.addTarget(self, action: #selector(creatAccountButtonEnabled), for: .editingChanged)
    return tf
  }()
  
  lazy var emailTextField: TextFieldUnderline = {
    let tf = TextFieldUnderline()
    tf.placeholder = "Email"
    tf.keyboardType = .emailAddress
    tf.autocorrectionType = .no
    tf.spellCheckingType = .no
    tf.addTarget(self, action: #selector(creatAccountButtonEnabled), for: .editingChanged)
    return tf
  }()
  
  lazy var passwordTextField: TextFieldUnderline = {
    let tf = TextFieldUnderline()
    tf.placeholder = "Password"
    tf.keyboardType = .emailAddress
    tf.autocorrectionType = .no
    tf.spellCheckingType = .no
    tf.isSecureTextEntry = true
    tf.addTarget(self, action: #selector(creatAccountButtonEnabled), for: .editingChanged)
    return tf
  }()
  
  lazy var checkPasswordTextField: TextFieldUnderline = {
    let tf = TextFieldUnderline()
    tf.placeholder = "Check Password"
    tf.keyboardType = .emailAddress
    tf.autocorrectionType = .no
    tf.spellCheckingType = .no
    tf.isSecureTextEntry = true
    tf.addTarget(self, action: #selector(creatAccountButtonEnabled), for: .editingChanged)
    return tf
  }()
  
  lazy var passwordCheckLabel: UILabel = {
    let lb: UILabel = UILabel()
    lb.textColor = .systemRed
    lb.font = .preferredFont(forTextStyle: .footnote)
    lb.textAlignment = .center
    self.addSubview(lb)
    return lb
  }()

  lazy var creatAccountButton: CustomButton = {
    let bt = CustomButton(title: "Create Account")
    self.addSubview(bt)
    return bt
  }()
  
  lazy var textFieldStackView: UIStackView = {
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
      creatAccountButton.layer.opacity = 1
      creatAccountButton.isEnabled = true
    } else {
      creatAccountButton.layer.opacity = 0.2
      creatAccountButton.isEnabled = false
    }
  }
  
  private func setAutolayout() {
    cancelButton.translatesAutoresizingMaskIntoConstraints = false
    mainLabel.translatesAutoresizingMaskIntoConstraints = false
    subLabel.translatesAutoresizingMaskIntoConstraints = false
    textFieldStackView.translatesAutoresizingMaskIntoConstraints = false
    passwordCheckLabel.translatesAutoresizingMaskIntoConstraints = false
    creatAccountButton.translatesAutoresizingMaskIntoConstraints = false
    
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
      
      creatAccountButton.topAnchor.constraint(equalTo: passwordCheckLabel.bottomAnchor, constant: 14),
      creatAccountButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
      creatAccountButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
      creatAccountButton.heightAnchor.constraint(equalToConstant: 60)
    ])
  }
}

